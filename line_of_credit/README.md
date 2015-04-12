## Line of Credit Challenge

### Assumptions
- The second provided example caused some confusion for me, so I made a critical assumption. The problem stemmed from the interest calculation. There seemed to be an off-by-one error with the calculation, which lead to interest either being calculated including the day it was borrowed/payed or not. In the case of the $500 loan on the first day, its interest was calculated for 30 days (30 - 1 + 1), but the others, like $100 on day 25, were calculated for 5 days (30 - 25). This first one was calculated for the day it was taken out and the remainder of the month, but the others were only calculated for the remainder of the month. <br><br> I made the assumption that the former was true, that interest was calculated including the day it was taken out.

- Interest should accrue over months. So, if we are looking for interest on day 60 it should be interest(month = 1) + interest(month = 2), etc.



### Spec
To run the spec, use `ruby -Ilib:test spec/credit_line_spec.rb`.

### Code Style
I used [Rubocop](https://github.com/bbatsov/rubocop) to analyze my code.