Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066CACD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:45:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D31BA40285;
	Wed, 27 May 2026 13:45:15 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id B8FA34026C
 for <dev@dpdk.org>; Wed, 27 May 2026 13:45:11 +0200 (CEST)
X-QQ-mid: Yeas1t1779882305t249t00678
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 6589427953331909869
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-15-zaiyuwang@trustnetic.com>
 <20260517165032.059933d3@phoenix.local>
In-Reply-To: <20260517165032.059933d3@phoenix.local>
Subject: RE: [PATCH v4 14/20] net/txgbe: fix link stability for Amber-Lite
 backplane mode
Date: Wed, 27 May 2026 19:45:03 +0800
Message-ID: <00c301dcedce$422b4490$c681cdb0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAegD/DgBb1cI4rVM1LHQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OJVlX7oey6I0Ng7XEow5gyiPVncPCm7NqqLWtGdoEZWRWiX0d0EcWpuc
 lzUH3uW8/tW9Omz+NdvP20sf/gGN95kEZ5RfB9jjqUTbsnnN/vT7M1GxWhzspkPwEvnpQQ0
 LLTBFcuHZxixHWNfSdCN8ube5AKeaH7y9X3VZ9gILbCRHzZ7nnWSs8ad921rnPTLznTH8TN
 fIuqrz27SseXlUnRov1qXdM6YmTA6XgRIkh/QUdiCTpdwDLvYNBQUpxduAJnXBs5+iXheid
 GLXp/+uEIT0B3HthvnqgT3z/3NGAZ39tG4FvGwumYz7yTemY/UIlSWVs+o/kTPWMeGpV+XW
 euyBkAyVdl/W79U5iaQJG1r41NLUS0NR5dywwFNjTsx/BZfVydWQmT2X6g0/2cL2wzQot60
 MJZaRHHd0fbLY4zCn10FL8EQigt6kqHZ+7uIk1+NUhoqssjKKfxrMW5MbE6noSPtqfRO+H4
 omnkEXFE+l2H5u7NAQB0/QUEyQtf/Dd/eg30Q+/2c2t9ZPgwc67nmCslCGG5vlGaQWi4SYB
 4rC3oKFd5LgVaHySdWAZ3LM/LcQG8jW5y8aPQWb9ryrV16n8RzFobhtwePoJtZGrYzQhnZR
 4IngeD3ftnGaEluplF7vlYOEYXOs6B5pudQMNonDVYO3sPoLClBq45OpLZR1TDthZgsD7Mb
 y+lrhD1z+tAjPZbQdFY6Eb6aUpEI4PtiVhcYQUZ4bvFfXCmNrzH1k5cp6pQEdtSyvw7AnLz
 N8bCDgZl0+cI4n8sb5SV9QVHkLUVGZP8OQpRXEqBrkFOBoTolrj+ctDGR6KBzZQr6L0twq3
 1ZxyRgWyBfn2DJGcoGaSIOmc1iNR7+I90z/ximdyeFiPJ7zi0GbWNv/7l81elFEEvidRrrZ
 OGBSfUtxJsQnMHwCLGN1Cy+LZXj8tWUTeCDktVh+GtrFA8uGAMQ2X4rIhki743u3nqB3CIE
 rez3Mry4o6ZNozhjVRJxj+6s49+QBL40HNcm3q33Za0DMtISPae+uQvdk2NA9i2QqPAONpO
 PyN8U3Yshxq5048jWp96bOy9I9u5Y=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

> Lots of AI feedback here:
>=20
>=20
> # Review of DPDK Patch: net/txgbe: fix link stability for 40G NIC
>=20
> ## Summary
> This patch re-adds direct PHY configuration flow to the txgbe driver =
to fix unstable link behavior on
> 40G NICs. The previous firmware-based configuration approach was =
causing link stability issues.
>=20
> ## ERRORS
>=20
> ### 1. Use-after-free risk in `txgbe_setup_phy_link_aml40`
Fixed.

> ### 2. Missing error propagation in `txgbe_e56_rx_rd_second_code_40g`
Fixed. This function has been changed to void type, as its configuration =
flow does not produce any error return value under normal operation.

> ### 3. Missing bounds check before array access
Fixed by introducing the RXS_READ_COUNT macro to keep the array size, =
loop bound, and median calculation always consistent.

> ### 4. Timeout return without cleanup in =
`txgbe_e56_rxs_calib_adapt_seq_40G`
Not a error.

=20
> ## WARNINGS
>=20
> ### 1. Hardcoded timeout in multiple locations
Added a comment at the definition of PHYINIT_TIMEOUT clarifying that it =
is a loop iteration limit, not a fixed time unit. The actual timeout =
duration depends on the usec_delay() or msleep() value used inside the =
polling loop.=20

> ### 2. Potentially unreachable code after loop
Moved the comment before '}'.

> ### 4. Variable `bypass_ctle` hardcoded but declared as variable
Fixed.

> ### 5. Missing validation of speed parameter in initialization =
functions
Fixed.


=20
> ## INFORMATIONAL
>=20
> ### 1. Large function complexity
> ### 2. Magic numbers without symbolic constants
> ### 3. Duplicated initialization sequences The 40G initialization in =
`txgbe_e56_cfg_40g`=20
I prefer not to split the hardware configuration flow at this stage. The =
current structure closely follows the hardware vendor's recommended =
initialization sequence.
Most magic numbers are directly from the hardware specification, we do =
not change them at this stage.
The hardware register requirements for different speeds are not fully =
identical. Merging them would risk subtle bugs.

> ### 4. Temperature check frequency
This was indeed an omission after moving PHY configuration from firmware =
to the driver. Previously, temperature tracking was handled by firmware =
together with hardware setup. We have now added a new patch that =
implements periodic temperature tracking in the driver. The tracking =
sequence is invoked every 100ms as recommended. This patch will be =
submitted in the new version of this patchset.

=20

