Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF22CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 06:13:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DF924026A;
	Thu, 16 Oct 2025 08:13:57 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id CDB6340269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 08:13:54 +0200 (CEST)
X-QQ-mid: Yeas5t1760595227t848t16228
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.206.160.146])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 15771135538294304610
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>	<20250930095953.18508-1-zaiyuwang@trustnetic.com>
 <20251015150401.60b5cc80@hermes.local>
In-Reply-To: <20251015150401.60b5cc80@hermes.local>
Subject: RE: [PATCH v4 00/20] Wangxun new NIC support
Date: Thu, 16 Oct 2025 14:13:46 +0800
Message-ID: <002701dc3e64$0822eab0$1868c010$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKiC98C7jrCga9wsmi8xZSIVafTeAIR4g20ApZf1vyzEyvMIA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NzSvc8JXj5/NXNgyIAQp38XdmJ+0NcaK9hAoB/jvd4AGXCSQ/vW6VL1J
 6Xd9VzNMn+af6p6GWhQu+LhArHpNCzCKDKNBteoSCgx5LAkww1Oa0wTUckIyFQ9O+wV6m/3
 3oeSvlc0nDP9GwQKgGGGgt4dCvXwyd2aDppizIne8xmVjhmsPx8cpEmoYvK9NkGTU8LIeQq
 PbPlWpl/Ou+j3BXtOnDPNzb6O48JZ6YdRdzkE8kgqHI1hyjS1+0VD6IjTTPWV3CELTy+o05
 5HxVt3rVnwdFfgrClIUiJXMdeavgY/pVwvFLNExhiUT1zk/jgFYa361mtN8nuiI2wKAX3VX
 qx9sRLZ5lc4OZESSQcQg3GX8o+cTVqu+obFHBZ0fBkYEih2F9dS4tQAFJS1sBrkkxxNdSnz
 t2WlIR9pDMEO9sMuxpjFNgyiosAS+fSZkUGDz10DZc3hvwb5z//PtmkIb2JDrpeM0IbKZWK
 zNQsiSZOawnTBgogRNGlvpJFanhZia9pP/VHdlHCjF0OB4RVMBdnoVSJjBKePt1k6pn1qYw
 ruC1/01Z4hbsOoa1AT7lPV16QjVK0Ql+uy/1ZILFASO5lEvcoOMTuxrc6Pv2hblziK918Jd
 Ja7KFkbeh9qllLfzx5LAR/p2iYrJQ4TJRC7VV2atg/bmMrbcBAN8tD+d12lC7NnUw9yd2sv
 ZTo5+8FRf6LPdFrVzK4p8kXL7JfOfij7DUPOzKwaTWhS4CYRIJ0+buKoDFOSvPJ+q5H8GLE
 L4nyzoQQd3ZX5e5EWX6VrH0EnC/yivD2aA7oN3ZMiHLJCsbyisyt4B6Pw6/ITIelooU6c5H
 iyvHg9VTpfSD99D9lktEtfBjmuIjlveSf3I1VU8Hi3gR0DJVkr4LjVbrJxj10LM81kAcXzH
 8q41SjnQfWLh2/2kjoLX54mx0XdBak6C63AEw0NQS3zQAhOpgZSB+Ho2WJjCbJd5YuSmxtg
 sAy1j9eN4pGjKLtvpT583V6NUlr2I883KUnM+98ep6+MoIfw0IBnawiw5qrZACLz7K77+fg
 PPkY9la4Bq8kx38TmYy6OFHQRAgjc=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, October 16, 2025 6:04 AM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org
> Subject: Re: [PATCH v4 00/20] Wangxun new NIC support
> 
> On Tue, 30 Sep 2025 17:59:32 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > We have released a new NIC series: Amber-Lite, with two models
> > supporting 10G/25G and 40G rates. Due to minimal hardware differences
> > from existing 10G NICs, it remains supported within the txgbe driver.
> >
> > Zaiyu Wang (20):
> >   net/txgbe: add basic information for Amber-Lite 25G/40G NICs
> >   net/txgbe: add new SW-FW mailbox interface
> >   net/txgbe: add identification support for new SFP/QSFP modules
> >   net/txgbe: rename raptor to sp for Sapphire-specific code
> >   net/txgbe: add basic link configuration for Amber-Lite NICs
> >   net/txgbe: add support for PHY configuration via SW-FW mailbox
> >   net/txgbe: add RX&TX support for Amber-Lite NICs
> >   net/txgbe: add hardware reset change for Amber-Lite NICs
> >   net/txgbe: add MAC reconfiguration to avoid packet loss
> >   net/txgbe: add TX head Write-Back mode for Amber-Lite NICs
> >   net/txgbe: add RX desc merge mode for Amber-Lite NICs
> >   net/txgbe: add FEC support for Amber-Lite 25G NICs
> >   net/txgbe: add GPIO configuration
> >   net/txgbe: disable unstable features
> >   net/txgbe: add support for TX laser enable/disable
> >   net/txgbe: add support for TX queue rate limiting
> >   net/txgbe: add support for getting PHY ID
> >   net/txgbe: add thermal sensor configuration for Amber-Lite NICs
> >   net/txgbe: add RSS for Amber-Lite NICs
> >   doc: update for txgbe
> >
> >  doc/guides/nics/txgbe.rst                 |   8 +-
> >  drivers/net/txgbe/base/meson.build        |   2 +
> >  drivers/net/txgbe/base/txgbe_aml.c        | 354 ++++++++++++++++++++
> >  drivers/net/txgbe/base/txgbe_aml.h        |  22 ++
> >  drivers/net/txgbe/base/txgbe_aml40.c      | 160 +++++++++
> >  drivers/net/txgbe/base/txgbe_aml40.h      |  20 ++
> >  drivers/net/txgbe/base/txgbe_devids.h     |   9 +
> >  drivers/net/txgbe/base/txgbe_eeprom.c     |   7 +-
> >  drivers/net/txgbe/base/txgbe_eeprom.h     |   2 +
> >  drivers/net/txgbe/base/txgbe_hw.c         | 365 ++++++++++++++++----
> >  drivers/net/txgbe/base/txgbe_hw.h         |  15 +-
> >  drivers/net/txgbe/base/txgbe_mng.c        | 184 +++++++++-
> >  drivers/net/txgbe/base/txgbe_mng.h        |  34 +-
> >  drivers/net/txgbe/base/txgbe_osdep.h      |   2 +
> >  drivers/net/txgbe/base/txgbe_phy.c        | 127 ++++++-
> >  drivers/net/txgbe/base/txgbe_phy.h        |  24 ++
> >  drivers/net/txgbe/base/txgbe_regs.h       | 103 +++++-
> >  drivers/net/txgbe/base/txgbe_type.h       |  70 +++-
> >  drivers/net/txgbe/base/txgbe_vf.c         |   2 +-
> >  drivers/net/txgbe/txgbe_ethdev.c          | 390
> ++++++++++++++++++++--
> >  drivers/net/txgbe/txgbe_ethdev.h          |   2 +-
> >  drivers/net/txgbe/txgbe_ethdev_vf.c       |   2 +-
> >  drivers/net/txgbe/txgbe_flow.c            |   2 +-
> >  drivers/net/txgbe/txgbe_rxtx.c            | 203 ++++++++---
> >  drivers/net/txgbe/txgbe_rxtx.h            |   3 +
> >  drivers/net/txgbe/txgbe_rxtx_vec_common.h |  27 +-
> >  26 files changed, 1937 insertions(+), 202 deletions(-)  create mode
> > 100644 drivers/net/txgbe/base/txgbe_aml.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
> >  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h
> 
> Please add (as follow on patch) short summary for release notes for 25.11
> 
Will do right away. Thanks.

