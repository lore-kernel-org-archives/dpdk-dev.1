Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9E6CA1013
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 03:00:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F72A40264;
	Mon,  8 Sep 2025 05:00:09 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 1AA0F400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 05:00:05 +0200 (CEST)
X-QQ-mid: Yeas2t1757300400t998t59546
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [36.20.62.83])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 10530684570362990044
To: "'Stephen Hemminger'" <stephen@networkplumber.org>, <hau@realtek.com>,
 <drc@linux.ibm.com>, <howard_wang@realsil.com.cn>,
 <jianwang@trustnetic.com>, <sachin.saxena@oss.nxp.com>,
 <xing_wang@realsil.com.cn>, <zaiyuwang@trustnetic.com>
Cc: <dev@dpdk.org>
References: <20250906091932.33d61730@hermes.local>
In-Reply-To: <20250906091932.33d61730@hermes.local>
Subject: RE: MAINTAINERS checkin
Date: Mon, 8 Sep 2025 10:59:59 +0800
Message-ID: <018c01dc206c$aa507a70$fef16f50$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEmcZJcTgxW3Tf4Ho40seBNU1L2a7Xz9SQA
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N/EN6P+BmEafZnwphE+I2wMJNCUibhv9lYdb/vHaljhnEg62k2KW8HP+
 g18Jz9JfTJGHm3/fD+hj/8ufbXqqrKf5eHPy6EaYvbf7E6GMpGdHhiqLkJ/sYqF1zYCVJUy
 yzRiHHMSZw7tc1IkTbiiloFkRJ4MnT/EBL41hB1Yb3shUgo/jEvx2toaMdA9neghGdJIrek
 iHynFEPcvGTeHywwKAS3DSkXtN+axW+w47i3oXa79FUCrae6oGOZEqJAdlsbp6EQx1DzgIn
 Syhs55amzg7wYwx/FVbJCLH6t4Du61+g1tD8NDlHqPVwXKp+JRPeZDVYkqU2wtXEQoQi5Ah
 8G8ow+hoUz2vHKV6GtpDbZcNO+iLYaiIaN4mXVHocKVBvNLkjK3AXp/L1XlqWxFWSlhKQaf
 LBuFK01cKhALmN3ObEjFp3Pkcb0YU/IT1E8aDX4yPtPF5Mp2E3YCBvKxVlG/TTxeisLjEYq
 sTEy+XC+CoQIPb7nlEKSqPkTQ7O+jA9L32+6M2fFMNaf4xRD8dQYVjRBkouy0v0MsdvNEOc
 aGBFs3Dq6QLxG25YAu+IpQ5amMWvqS1ZDQ2tqhDD44QdlMCqSgUqg50uGoiRSHVJkhRFAkI
 a1XBI3YL9P/7s16gNCd13/ZqFDXddh15jdU44PGHfU0ZQ/JgdnYdYEHO5vhuhjRMqnjXAIx
 pH4/UF+45LreYKQ5WKTX75+y+91m4/SljZnkvRWYae/w+sYqRptUsOEFJ2iDo6wwZFR0C67
 P0i6FL+9FDd5mrG/OJ/pPntQZu0IWTkjsBTsJYdi5sdcj6RyYrqgmx7HKfzfRqKOFvWTyAy
 kKXofFFs//H+ePxpoh3tCVFBM/U5Y9Iju/lFc8KdVV8oZXgunZaivY+8nGD8iYEEpkes1u0
 9flkO5JbncDpwxZWvNUj92sNj9fl+YdbjCi37qTFug5jcDcMMQ0NEWJj788iRG90YH/ot/i
 hLhXtdxK2HbHe8VTmBFFBOL6GFGiLSbhqPy+A42PON9iiKhzw9L+5crVAiewdQdBAeIu70E
 PPKVMOsWlBkrGyTDMLrYgIN/K4I/6cVwMMw3RDTDdvt5Y5nlSo
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
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

Hi Stephen,

There is our old domain which names trustnetic.com.
Now we use net-swift.com, but the email address with
the old domain can still be used.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday, September 7, 2025 12:20 AM
> To: hau@realtek.com; drc@linux.ibm.com; howard_wang@realsil.com.cn; =
jianwang@trustnetic.com; jiawenwu@trustnetic.com;
> sachin.saxena@oss.nxp.com; xing_wang@realsil.com.cn; =
zaiyuwang@trustnetic.com
> Cc: dev@dpdk.org
> Subject: MAINTAINERS checkin
>=20
> The following email addresses no longer appear to be valid.
> See attached python script (AI generated) for validation.
>=20
> Invalid Emails:
> ------------------------------
> =E2=80=A2 hau@realtek.com
>   - Domain does not exist or is unreachable
> =E2=80=A2 drc@linux.ibm.com
>   - Domain does not exist or is unreachable
> =E2=80=A2 howard_wang@realsil.com.cn
>   - Domain does not exist or is unreachable
> =E2=80=A2 jianwang@trustnetic.com
>   - Domain does not exist or is unreachable
> =E2=80=A2 jiawenwu@trustnetic.com
>   - Domain does not exist or is unreachable
> =E2=80=A2 sachin.saxena@oss.nxp.com
>   - Domain does not exist or is unreachable
> =E2=80=A2 xing_wang@realsil.com.cn
>   - Domain does not exist or is unreachable
> =E2=80=A2 zaiyuwang@trustnetic.com
>   - Domain does not exist or is unreachable


