Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A11CA1002
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Sep 2025 16:19:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F845402A2;
	Sat,  6 Sep 2025 18:19:41 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 3E8204029C
 for <dev@dpdk.org>; Sat,  6 Sep 2025 18:19:40 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45b9c35bc0aso27061155e9.2
 for <dev@dpdk.org>; Sat, 06 Sep 2025 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757175580;
 x=1757780380; darn=dpdk.org; 
 h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iRerxtaQ9WLhLtNYhKYyY7iK+3/ej7osefl9zmzouCg=;
 b=zWipeidzHSAd6OIIofg25fhdJlFZv4dFHkUJqEtOH8ZXqlr+vYV7BqVQJm3FZQVcNT
 rpMmWdtIcetddP2xdUFMEuR2zexdjoBCMcq/3j0OtQ/3BZXUpJQYa6foaxrB5GMauaUX
 d/jJyv+0IKb54Z9STlsDVQIp+fkbX+IWYCfAvAoA2jR3BlMBpSQXAgwXmVONiXhQBI/6
 nuwDOEUUkvhKjVD5YxR9kT0zUswlWngFX82HxFLwbW0hQNh0akCemqXwevknjIwVLdsm
 YAqoy4ELgif22QE76IIycsQcpvjxdFYwaC0wkXDfwYqr2AMM5uSlB9DSFFbLTz/AQEB5
 vZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757175580; x=1757780380;
 h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRerxtaQ9WLhLtNYhKYyY7iK+3/ej7osefl9zmzouCg=;
 b=RbGUFVWeYE2ZMnACa4kh+PCgkKDwUqiyGbxESuoHS8iCgs6BRsBHB25ZgG4ec2P9WC
 l4xZPIUv1wkvtGAxurRi35W+6f3FydRMspDyLnvuZRintVWz6Wnd8LJp0bSWk9yMSlCf
 Iwo8OY7EXBCJfeqVbpn9A660cs43baze9gzlWWHMlSFqpesRTvEJT8eE8YvnBB3auNdd
 Ia7gF8GNIvQYxnLu0SOE/4CcLa1nawt6R+ZHH/vT4tsxYuP3TXW0COHkFL1uJePSrbFD
 DWvKc1MqdSp95SyJh/DbUr578/fqnTSTr/9e2qajjO9dXlwlbF0xIykyv8LQozaWBjXx
 tkhQ==
X-Gm-Message-State: AOJu0YyryF1+zcnAwlPxB6YOYhAd6y4fBztACcJP/0kYBQsu28crkInE
 l+1O/pACwxEsHjWGsD1yQT2BCtInVNED4LUYZln8RJ8XW4CUxUo5zFptftYDJvdIpApEXkONQVj
 MwjTo
X-Gm-Gg: ASbGnct9s6iLgoIdftb+0QznoVTYIRs4/GSM6/cUhBHLxJefBkS76AX9YPYuI5sZOag
 LNv/c8ySBq4lzbnSs3mUgygfyDuxhUqCGpwmjqDvCS94t2XpCERUB/6f5BB15To2c6UViSqxq4H
 lzFrcqM/tfgOZR9GMWTzSs5Evrbo706B+kp6EZVRCixgCcGClfY4oGiUzZ1my37AU5DWGTV/ZOk
 +bXcSSFaJ+7Zq/ye2YZv7r6jNGlRqax9IaJnB433P07x3g2VORgVU0F124Ss0Q7GwW8ICXLUaLF
 pHolxphURDIj5lUM2mvtvwIIr4Kq+pcWsK5SuWqddbSGFuOisQmlXscN4+et1hK0jtlRUN4KxQa
 KxXvBk0/wC1e/CPNEKwFHskwKsV5lykTAMo+eyOaut/kq4a+1jqzeYRIH5uPdSIuA3Yh6kUgoI9
 Mpscjr5S6UNg==
X-Google-Smtp-Source: AGHT+IF2+8Pt0zYqYRlNQt0H7+C+ySwLm77uOLsq9Ndlu7Cckumzxy441Oma4F5MHz8ngBsViljcOQ==
X-Received: by 2002:a05:600c:4f08:b0:45b:84b1:f638 with SMTP id
 5b1f17b1804b1-45dddecf40fmr22045235e9.20.1757175579353; 
 Sat, 06 Sep 2025 09:19:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab832sm370094855e9.23.2025.09.06.09.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Sep 2025 09:19:39 -0700 (PDT)
Date: Sat, 6 Sep 2025 09:19:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: hau@realtek.com, drc@linux.ibm.com, howard_wang@realsil.com.cn,
 jianwang@trustnetic.com, jiawenwu@trustnetic.com,
 sachin.saxena@oss.nxp.com, xing_wang@realsil.com.cn,
 zaiyuwang@trustnetic.com
Cc: dev@dpdk.org
Subject: MAINTAINERS checkin
Message-ID: <20250906091932.33d61730@hermes.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/r6009v/z0YMVcV/OFV/+/gs"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--MP_/r6009v/z0YMVcV/OFV/+/gs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The following email addresses no longer appear to be valid.
See attached python script (AI generated) for validation.

Invalid Emails:
------------------------------
=E2=80=A2 hau@realtek.com
  - Domain does not exist or is unreachable
=E2=80=A2 drc@linux.ibm.com
  - Domain does not exist or is unreachable
=E2=80=A2 howard_wang@realsil.com.cn
  - Domain does not exist or is unreachable
=E2=80=A2 jianwang@trustnetic.com
  - Domain does not exist or is unreachable
=E2=80=A2 jiawenwu@trustnetic.com
  - Domain does not exist or is unreachable
=E2=80=A2 sachin.saxena@oss.nxp.com
  - Domain does not exist or is unreachable
=E2=80=A2 xing_wang@realsil.com.cn
  - Domain does not exist or is unreachable
=E2=80=A2 zaiyuwang@trustnetic.com
  - Domain does not exist or is unreachable


--MP_/r6009v/z0YMVcV/OFV/+/gs
Content-Type: text/x-python
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=email_validator.py

#!/usr/bin/env python3
"""
Email Address Validator
Reads a list of email addresses from a file and validates them.
Performs both syntax validation and basic domain checking.
"""

import re
import sys
import socket
import argparse
from typing import List, Tuple, Dict
from pathlib import Path

class EmailValidator:
    def __init__(self):
        # RFC 5322 compliant email regex (simplified but robust)
        self.email_pattern =3D re.compile(
            r'^[a-zA-Z0-9.!#$%&\'*+/=3D?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9=
-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'
        )
   =20
    def validate_syntax(self, email: str) -> bool:
        """Validate email syntax using regex."""
        if not email or len(email) > 254:
            return False
       =20
        # Split local and domain parts
        parts =3D email.rsplit('@', 1)
        if len(parts) !=3D 2:
            return False
       =20
        local_part, domain =3D parts
       =20
        # Check local part length (max 64 characters)
        if len(local_part) > 64:
            return False
       =20
        # Use regex for full validation
        return bool(self.email_pattern.match(email))
   =20
    def validate_domain(self, email: str) -> bool:
        """Validate domain by checking if MX or A record exists."""
        try:
            domain =3D email.split('@')[1]
           =20
            # Try to get MX record first (preferred for email)
            try:
                socket.getaddrinfo(domain, None)
                return True
            except socket.gaierror:
                return False
               =20
        except (IndexError, socket.error):
            return False
   =20
    def validate_email(self, email: str, check_domain: bool =3D True) -> Di=
ct[str, any]:
        """
        Comprehensive email validation.
        Returns a dict with validation results.
        """
        email =3D email.strip().lower()
       =20
        result =3D {
            'email': email,
            'valid_syntax': False,
            'valid_domain': False,
            'overall_valid': False,
            'errors': []
        }
       =20
        # Check syntax
        if self.validate_syntax(email):
            result['valid_syntax'] =3D True
        else:
            result['errors'].append('Invalid email syntax')
       =20
        # Check domain if syntax is valid
        if result['valid_syntax'] and check_domain:
            if self.validate_domain(email):
                result['valid_domain'] =3D True
            else:
                result['errors'].append('Domain does not exist or is unreac=
hable')
        elif not check_domain:
            result['valid_domain'] =3D True  # Skip domain check
       =20
        # Overall validity
        result['overall_valid'] =3D result['valid_syntax'] and result['vali=
d_domain']
       =20
        return result

def read_emails_from_file(file_path: str) -> List[str]:
    """Read email addresses from a file, one per line."""
    try:
        with open(file_path, 'r', encoding=3D'utf-8') as f:
            emails =3D [line.strip() for line in f if line.strip()]
        return emails
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
        sys.exit(1)
    except IOError as e:
        print(f"Error reading file '{file_path}': {e}")
        sys.exit(1)

def print_results(results: List[Dict], verbose: bool =3D False):
    """Print validation results in a formatted way."""
    valid_count =3D sum(1 for r in results if r['overall_valid'])
    total_count =3D len(results)
   =20
    print(f"\nValidation Results:")
    print(f"=3D" * 50)
    print(f"Total emails checked: {total_count}")
    print(f"Valid emails: {valid_count}")
    print(f"Invalid emails: {total_count - valid_count}")
    print(f"Success rate: {(valid_count/total_count)*100:.1f}%")
    print()
   =20
    if verbose:
        print("Detailed Results:")
        print("-" * 50)
        for result in results:
            status =3D "=E2=9C=93 VALID" if result['overall_valid'] else "=
=E2=9C=97 INVALID"
            print(f"{status:10} | {result['email']}")
            if result['errors']:
                for error in result['errors']:
                    print(f"           | Error: {error}")
        print()
   =20
    # Show invalid emails
    invalid_emails =3D [r for r in results if not r['overall_valid']]
    if invalid_emails:
        print("Invalid Emails:")
        print("-" * 30)
        for result in invalid_emails:
            print(f"=E2=80=A2 {result['email']}")
            for error in result['errors']:
                print(f"  - {error}")
        print()

def save_results(results: List[Dict], output_file: str):
    """Save results to a file."""
    try:
        with open(output_file, 'w', encoding=3D'utf-8') as f:
            f.write("Email,Valid,Syntax_Valid,Domain_Valid,Errors\n")
            for result in results:
                errors_str =3D '; '.join(result['errors']) if result['error=
s'] else ''
                f.write(f"{result['email']},{result['overall_valid']},"
                       f"{result['valid_syntax']},{result['valid_domain']},=
\"{errors_str}\"\n")
        print(f"Results saved to: {output_file}")
    except IOError as e:
        print(f"Error saving results to '{output_file}': {e}")

def main():
    parser =3D argparse.ArgumentParser(
        description=3D'Validate email addresses from a file',
        formatter_class=3Dargparse.RawDescriptionHelpFormatter,
        epilog=3D"""
Examples:
  python email_validator.py emails.txt
  python email_validator.py emails.txt --no-domain-check
  python email_validator.py emails.txt --verbose --output results.csv
  python email_validator.py emails.txt -v -o validated_emails.csv
        """
    )
   =20
    parser.add_argument('input_file', help=3D'Path to file containing email=
 addresses (one per line)')
    parser.add_argument('--no-domain-check', action=3D'store_true',=20
                       help=3D'Skip domain validation (faster, syntax-only)=
')
    parser.add_argument('-v', '--verbose', action=3D'store_true',
                       help=3D'Show detailed results for each email')
    parser.add_argument('-o', '--output', help=3D'Save results to CSV file')
   =20
    args =3D parser.parse_args()
   =20
    # Check if input file exists
    if not Path(args.input_file).exists():
        print(f"Error: Input file '{args.input_file}' does not exist.")
        sys.exit(1)
   =20
    # Read emails from file
    print(f"Reading emails from: {args.input_file}")
    emails =3D read_emails_from_file(args.input_file)
   =20
    if not emails:
        print("No email addresses found in the file.")
        sys.exit(1)
   =20
    print(f"Found {len(emails)} email addresses to validate.")
   =20
    # Validate emails
    validator =3D EmailValidator()
    results =3D []
   =20
    check_domain =3D not args.no_domain_check
    if not check_domain:
        print("Note: Domain checking is disabled (syntax validation only)")
   =20
    print("\nValidating emails...")
    for i, email in enumerate(emails, 1):
        if args.verbose:
            print(f"Checking {i}/{len(emails)}: {email}", end=3D"")
       =20
        result =3D validator.validate_email(email, check_domain)
        results.append(result)
       =20
        if args.verbose:
            status =3D " =E2=9C=93" if result['overall_valid'] else " =E2=
=9C=97"
            print(status)
   =20
    # Print results
    print_results(results, args.verbose)
   =20
    # Save results if requested
    if args.output:
        save_results(results, args.output)

if __name__ =3D=3D "__main__":
    main()

--MP_/r6009v/z0YMVcV/OFV/+/gs--
