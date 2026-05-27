Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9C2CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:45:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C86AF40663;
	Wed, 27 May 2026 13:45:20 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 87DE740663
 for <dev@dpdk.org>; Wed, 27 May 2026 13:45:18 +0200 (CEST)
X-QQ-mid: Yeas9t1779882313t441t49043
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 5999459029939401772
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-13-zaiyuwang@trustnetic.com>
 <20260517164936.1c83977e@phoenix.local>
In-Reply-To: <20260517164936.1c83977e@phoenix.local>
Subject: RE: [PATCH v4 12/20] net/txgbe: fix link stability for 25G NIC
Date: Wed, 27 May 2026 19:45:11 +0800
Message-ID: <00c401dcedce$47007350$d50159f0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAb2dEB4B9dmQTLVJ8hFg
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Ndw/mc8X39ObqNipA715+BAiZRi+IpUgFFfp/RhLdF1fCYBGvauzss/V
 ek1PnFEuOO44dKgNUBora9KqYTqf1C0sqAapC3x0uE3BdDIE2SMmT1kaBQUOUcd7KbCf4tR
 i1YGtFo3ujhX1DtRz0oE3G5zFnf6xZxCnRNbrA43mjuv2Hf/j6wqsgj1bZiX4I8h+l8IykG
 3QnPOjwP4oOtYxa5QXUoOo6/RMDCTym1jzr0CZXYLjs5pKw9yIPI+UnZEMsh+y7eVlEad26
 lv5p8TGRHNOM9HLpg3FizbGNUQ6YZ9HUeOC4ZfnFtjksApERGv8yE6Td+lqlpx4Co4PIKz/
 T/Cb1ZtWyBTl11dGU0uS65uAVB1cDOJDLN80mZ1+/k9ktcKzgBzLhlc8tsO9yflH85lr23z
 2jIGTy1kG2Tp2kOJcfQcwm50Cs2e7iyU1yW8T67jSC9o4nVpd23U22/gL1mgNtaD8tc/iop
 YF4QPJCSOZnqautKtI8v0M7EtUFTBw1G4hgC2F3czFA2q1xXsMr5okh2k3yCw7rrSh+/kus
 HQAVjDnmvJZlumhOw2787BvR3n3uUhlTj8e7cxeVmDTd3tyLkBdbSnnw566V2RZNdoowkIZ
 aq+tof1MwBvfm8YapH/ULjGFNG2ocZJrpHpEvdmLeWlo/FMvMisk7/72dVdQ8yFGxgoK+hY
 RGr2Oq5KPVCwtOCNy3ylndDQ+fkpaULqJiIsAh4Hq0w14q7/ZpYr2hK1tFFB3ZruaP4Efid
 RLbB5Tc5roZcvzl+zTgUFJWvNrKylLZdmrKVVkdroeIbHjYwJSg6pQ/roEoeBFl7xD6psOV
 pbv/t5JxRXOnoUjLIJiqSlIv/WxKNXDwj+ZqSHgjIcKYa38txCNUDgw8TjCmRgwloiCcPJO
 ikp9hoWB6Oto8fDC4ghyK/TG57epRmuBclk3miaPG1jA0O+Bv1lsfYzCh7H9OA3b0hJq97e
 oPbjIGDCZ/zfupqYkk6/oueywX/lu2kAuQ8NC1eTgmNq108SYfU1MAnKTJpMwJGGeUGkM8f
 p32NYN12ZaQn95ruZh8pblxbAlKzE=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

> ## Errors
>=20
> ### 1. Use-after-free potential in txgbe_e56_rxs_calib_adapt_seq =
(CORRECTNESS)
No code change.
The return value of txgbe_e56_rxs_osc_init_for_temp_track_range is only =
used for debugging; the hardware can still continue the subsequent =
configuration flow even after a timeout. Therefore, we use status |=3D =
to record the error for logging but do not abort the sequence.

> ### 2. Resource leak: lock not released on error path (CORRECTNESS)
No code change.
The spinlock is correctly released on all paths, including the =
TXGBE_ERR_PHY_INIT_NOT_DONE branch. No change is needed.

> ### 3. Missing error propagation to caller (CORRECTNESS)
Fixed. The function now returns TXGBE_ERR_TIMEOUT when the link fails to =
come up.

> ### 4. Double error return value overwrite (CORRECTNESS)
Fixed by removing the break statements and letting the timeout errors =
return immediately.

> ### 5. Error code dropped without propagation (CORRECTNESS)
No code change.
A failed temperature read does not affect the subsequent configuration =
flow; stopping the process would be too aggressive. The function =
intentionally continues, and the error is only for debug purposes.

> ### 6. Integer overflow in bit shift (CORRECTNESS)
Fixed

> ### 7. Missing bounds check on array size calculation (CORRECTNESS)
Fixed by introducing the RXS_READ_COUNT macro to keep the array size, =
loop bound, and median calculation always consistent.

> ## Warnings
>=20
> ### 1. Variables declared but may be read before initialization =
(STYLE)
Adjusted the declaration of need_reset to the function scope for =
improved readability.

> ### 2. Missing documentation for complex algorithm (STYLE)
Acknowledged. Adding a high=E2=80=91level comment for the complex =
calibration procedure is planned

> ### 3. Magic numbers without named constants (STYLE)
No code change.
These values come directly from the hardware vendor and are located in =
the base/ layer, which we prefer not to modify without an official =
update. We will keep them as=E2=80=91is.


> ## Info
>=20
> ### 1. Deep nesting in calibration sequence
Considering that this is the hardware configuration code located in =
base/, for now we will not make change to it.

> ### 2. Possible candidate for helper function
Considering that this is the hardware configuration code located in =
base/, for now we will not make change to it.=20
=20

