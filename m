Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E594DCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:21:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C4A540650;
	Wed, 27 May 2026 13:21:34 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 00D314028A
 for <dev@dpdk.org>; Wed, 27 May 2026 13:21:31 +0200 (CEST)
X-QQ-mid: Yeas9t1779880885t808t18771
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 7455510100251041051
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-17-zaiyuwang@trustnetic.com>
 <20260517165225.6ba8b774@phoenix.local>
In-Reply-To: <20260517165225.6ba8b774@phoenix.local>
Subject: RE: [PATCH v4 16/20] net/txgbe: fix SFP module identification
Date: Wed, 27 May 2026 19:21:24 +0800
Message-ID: <00c201dcedca$f41e37b0$dc5aa710$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAV3T1uMCsX/db7U79aXg
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OJVhEmJj02aqmhIIzu74IFcmvfgC5Y6E7LGUqa+ONZbNtWgUUXBb0b8X
 tQL1QDme3AOcBfmGRf0TAzWtbmGOeuSCE1SAb5DNzsmN3pe6DEeHIgzqh0P/EXtArgPoLNi
 khTI8s0qwiYdHwlY31y4TCplphniflyYUVHtJS30VDtah9wabjVrrNlgTG3XB4/xiPY6wV2
 i1mCQdqN6Mtv1zkL6KTGsC4ByqSDQ/V7RURod3c28OBqBh/XXTevIJpzLJlLIJkJq3FJRfb
 UPDasFOHi090DDw+5BKvqheS0dRGZR91ifLfREf/jmBtCYbhYQyLG8t9erOLGSsPzv3RHeN
 4iEYcemXSMDPDGi9l0WARWAIu0fun9TGNiEy6/b4eAycu+TG81aKS9PWo7KMlHajr/48y5U
 ToDSsv8bUQFT1FGED5cDSpmHRbLOSIkc0biJZMOagaTr58ptLN7/Nibii6ab33zFaIptkAO
 BVsU/xEUNgrnoEUD12A4VLVz/AVH+Je3rtWDmCUp4jPtJ+qUCLU25Y/38RBTvp7VZthtv+t
 Bd5GSinqbUtmsLRPKodWRTt4XoU14ix18BAsB3EQGDAJHaN6mMjBXA62MV1U0CZPUgGPNLs
 aD1WJ+z0hhLo+KPl979y8e2jbCoscDRoofHEqmS5yG5u10i9rjNuAbO/EzW9YKZIXgJzxy/
 649/NZcJIbzdfU5wp3O4EgTHzBBpDMP0AdufA2vQfr0Yt/jWcNEZQ0gj42Drq64bwQiO7Uo
 9g/h/4FlIRTk5ut/lb6ZxlUeIsI32VEjs+7styQeF5T8T210XYbtI66SK+kIHRCIYLsHSdD
 z/Q0lLNboT5fepxvtNp+DcTRzbzOk2Vz3iCIOqTdsKeDtDZmp0aPKiK85/SwzpU/b3oQLos
 CMwNspcsc0x+kXlalzaVXvPToeyvuVuRemWG6quANLBF/IPKLJ33dwNwcGeA4HelrQzx+0v
 07OKWWBByBILXqItRVhMJy+o+o5JY4qd6ySJwFcPxphUE3b7YVUUS8NNcoErkr5gXps7RLh
 zHvcrKXWtPAf/eNITlm5hfUlr9ne6j4+bwdc+QOupEx+BNhcWqb0X7D4rhAo7tdZpuwY4Tt
 Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
> ### 1. Resource leak in `txgbe_identify_sfp_module()` - multiple error =
paths
> missing unlock
No code change
The review is incorrect =E2=80=94 all error paths after acquiring the =
lock do properly release it. There is no lock leak.

> ### 2. `txgbe_write_i2c_byte()` removes STOP condition - probable =
hardware
No code change
This change was ported from our out=E2=80=91of=E2=80=91tree Linux kernel =
driver. It was found that the previous write_i2c interface had problems, =
which caused ethtool -m to read some 40G optical module information =
incorrectly. Removing the intermediate STOP is intentional and fixes =
that issue.

> ### 3. Removed validation logic without replacement - SFP vendor =
checking
No code change
The old code was inherited from the Intel driver. The restriction has =
been removed intentionally: the driver now supports all optical modules =
that comply with the relevant standards, without limiting to a specific =
vendor.

> ## Warnings
>=20
> ### 1. `txgbe_identify_qsfp_module()` GPIO config runs unconditionally
No code change.
The function txgbe_identify_qsfp_module is only called for the =
Amber=E2=80=91Lite 40G NIC. Among the three NIC types supported by txgbe =
(Sapphire 10G, Amber=E2=80=91Lite 25G, Amber=E2=80=91Lite 40G), only the =
40G variant uses QSFP; the other two use SFP. Based on the aml40 =
hardware design, we need to configure the GPIO before using I2C.

> ### 2. Missing error propagation - `txgbe_read_i2c_sff8636()` page =
select failure
> ignored
Fixed.

> ### 3. Implicit comparison on pointer
Fixed.
=20
> ### 5. Function pointer assignments removed but functions still =
defined
Already verified.
=20

