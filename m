Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4DCCDB46B
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 03:16:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA6F04014F;
	Tue, 23 Jun 2026 05:16:08 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 620C64003C
 for <dev@dpdk.org>; Tue, 23 Jun 2026 05:16:06 +0200 (CEST)
X-QQ-mid: Yeas1t1782184559t767t30039
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.204.248.247])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 16462262551209469011
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260622111111.21024-1-zaiyuwang@trustnetic.com>
 <20260622083000.16a572ee@phoenix.local>
In-Reply-To: <20260622083000.16a572ee@phoenix.local>
Subject: RE: [PATCH v9 00/21] Wangxun Fixes
Date: Tue, 23 Jun 2026 11:15:58 +0800
Message-ID: <007001dd02be$9cb45a50$d61d0ef0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwHXiZW4AsmtdW61ej38QA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NrKIiCtjdVi7yMwwsD56t3ojiVRdhtl5VWo5/im7CMn71DfsmZSIoTRr
 KRQaOoywuLpe1d+HiWEMimi+g+ikZ4yF5/RZ8TAXkRoNN/C/XQMg8zb5T2pTKYy23rATz0S
 inqXP6P2L8R21vtB57GC9fsqeOwIUbhwmAeEDdVDrKveD1H+xcEq1/F1NVpiPmQ1vv0vaYE
 yFvfLGONTkfs6UG8IfGxBKL6t8Np2KXKl1zUoVzLZgSjdWY0B/ayz+SHEHnnCgNYirgGQvV
 gXnAY9/tK1zgRn5urrjeJO6xDTAZkACwkLCiGUtT3hI3SsfK5L5GnGnoQ7JPcgV6Z5deGNe
 iIVBlgfRzOu169iX3aQhjMX0xiaIKr4EgwPi0/bjCeW5d/nKBfbYade08UpoK0Oz+AK3eJW
 Et0VHhEY1OivGGemnN3+vLbjhuos37djNdYSa6qQOLwqgif/pftY6btjYZq4XFNBuFnd7kX
 THM9JiO686ypZi9egONLJnuno8M3+t8c2VnBwdHb5W5U4pTGVXwhePRn6yAGgtcO+JCxiCJ
 TXEZH2QQZs9fSERNGKvx4Oh4gNZqB/XYfG7InJh6qVR7ju8aEJFgKLex6kcddbY7oGv88SY
 mNq0ikehPCeLiasVK5jGvGyLNVvn8jq8KZ1LSv4uZUbBLavC5HbTRUVlDn3LLI/K2CexTKL
 7/Z291UbXGpMGpdtdfuWX2xokI2c+3Ph73moy0z7SN9zHFEW08Zja3sOxUnSWq9fn4LHuX+
 7fPMVznta2U+0QXoX4sv+jm5yFcZdlcw0f6fF96yuGzoj6cuOINh93b3gEnLw8KDANYoDTx
 a/V0AGi4EDXnAMiHOtZqo2nUxcarkr2psMqeaByP8Rd6dn0XJXskkW+MiQLK0ro82LgnjYi
 JC4WfRRFX4NbeIkKt0rUQN6/AVjbTS2t9cpfiYm9gse3LoUJD5+4aJWQrxrj7oLGDcLzyka
 KFfRoA5tzADlwIJmUogespVLXa/YTBCtEGrVEsxIfdFL04syyUp34gHCQBEEJKPLnhjNVcg
 gq+p+8AN+0TnOQpJ6gyg1aZxQ5Cq8PFEIsm6xNmG2WgHWpBbTXT1NJuRX/4HoBaT1ymyNWV
 vmoIBllAWtEKnawOzkuD0Nc9HL4II7gSnPmZESR2IndBrygt5VHhoA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
> Sent: Monday, June 22, 2026 11:30 PM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; dev@dpdk.org
> Subject: Re: [PATCH v9 00/21] Wangxun Fixes
> 
> On Mon, 22 Jun 2026 19:10:48 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > This series fixes several issues found on Wangxun Emerald, Sapphire
> > and Amber-lite NICs, with a focus on link-related problems.
> > ---
> > v9:
> > - Fixed several checkpatch errors
> > ---
> > v8:
> > - Fixed compilation error by replacing RTE_ETH_DEV_TO_PCI with
> > RTE_CLASS_TO_BUS_DEVICE
> > ---
> > v7:
> > - Fixed inverted semantics of is_flat_mem to match SFF8636
> > ---
> > v6:
> > - Fixed more issues identified by AI review
> > ---
> > v5:
> > - Fixed issues identified by AI review
> > ---
> > v4:
> > - Fixed issues identified by devtools scripts
> > ---
> > v3:
> > - Addressed Stephen's comments
> > ---
> > v2:
> > - Fixed compilation error and code style issues
> > ---
> >
> > Zaiyu Wang (21):
> >   net/txgbe: remove duplicate xstats counters
> >   net/ngbe: remove duplicate xstats counters
> >   net/ngbe: add missing CDR config for YT PHY
> >   net/ngbe: fix VF promiscuous and allmulticast
> >   net/txgbe: fix inaccuracy in Tx rate limiting
> >   net/txgbe: fix link status check condition
> >   net/txgbe: fix Tx desc free logic
> >   net/txgbe: fix link flow control registers for Amber-Lite
> >   net/txgbe: fix link flow control config for Sapphire
> >   net/txgbe: fix a mass of unknown interrupts
> >   net/txgbe: fix traffic class priority configuration
> >   net/txgbe: fix link stability for 25G NIC
> >   net/txgbe: fix link stability for 40G NIC
> >   net/txgbe: fix link stability for Amber-Lite backplane mode
> >   net/txgbe: fix FEC mode configuration on 25G NIC
> >   net/txgbe: fix SFP module identification
> >   net/txgbe: fix get module info operation
> >   net/txgbe: fix get EEPROM operation
> >   net/txgbe: fix to reset Tx write-back pointer
> >   net/txgbe: fix to enable Tx desc check
> >   net/txgbe: fix temperature track for AML NIC
> >
> >  drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
> >  drivers/net/ngbe/ngbe_ethdev.c            |    5 -
> >  drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
> >  drivers/net/txgbe/base/meson.build        |    2 +
> >  drivers/net/txgbe/base/txgbe.h            |    2 +
> >  drivers/net/txgbe/base/txgbe_aml.c        |  185 +-
> >  drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
> >  drivers/net/txgbe/base/txgbe_aml40.c      |  114 +-
> >  drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
> >  drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
> >  drivers/net/txgbe/base/txgbe_e56.c        | 3773 +++++++++++++++++++++
> >  drivers/net/txgbe/base/txgbe_e56.h        | 1753 ++++++++++
> >  drivers/net/txgbe/base/txgbe_e56_bp.c     | 2597 ++++++++++++++
> >  drivers/net/txgbe/base/txgbe_e56_bp.h     |  282 ++
> >  drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
> >  drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
> >  drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
> >  drivers/net/txgbe/base/txgbe_phy.c        |  362 +-
> >  drivers/net/txgbe/base/txgbe_phy.h        |   46 +-
> >  drivers/net/txgbe/base/txgbe_regs.h       |   13 +-
> >  drivers/net/txgbe/base/txgbe_type.h       |   43 +-
> >  drivers/net/txgbe/txgbe_ethdev.c          |  472 ++-
> >  drivers/net/txgbe/txgbe_ethdev.h          |    7 +-
> >  drivers/net/txgbe/txgbe_rxtx.c            |  109 +-
> >  drivers/net/txgbe/txgbe_rxtx.h            |   36 +
> >  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   17 +-
> >  26 files changed, 9464 insertions(+), 444 deletions(-)  create mode
> > 100644 drivers/net/txgbe/base/txgbe_e56.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
> >  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h
> >
> 
> Applied to next-net, but this driver still has some unprefixed symbols:
> 
>  $ nm ./drivers/librte_net_txgbe.a  | grep ' [TD] ' | grep -v ' txgbe'
> 0000000000000510 T set_fields_e56
> 0000000000007ca0 T handle_e56_bkp_an73_flow
> 
Thanks.

