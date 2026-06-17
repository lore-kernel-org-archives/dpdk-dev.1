Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D24CD98EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 01:38:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2EFC40276;
	Wed, 17 Jun 2026 03:38:25 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 952AA4026A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 03:38:23 +0200 (CEST)
X-QQ-mid: Yeas8t1781660298t161t18212
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [183.157.22.210])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 3582701648970842107
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260616122030.9688-1-zaiyuwang@trustnetic.com>
 <20260616144218.3bb7ea85@phoenix.local>
In-Reply-To: <20260616144218.3bb7ea85@phoenix.local>
Subject: RE: [PATCH v6 00/21] Wangxun Fixes
Date: Wed, 17 Jun 2026 09:38:16 +0800
Message-ID: <005201dcfdf9$f85b0170$e9110450$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwMCamxlAhWLkFC1bP3hsA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M4+GqYRlc6iCbFf9q16bwAov16wvg31JkDBhuduGRZm/+vaJBgRKu5m0
 98KB5FjcmJ/ZykRk+14mO+bpvFvOT8LhLbTd5/CZ5X+UWnYmJGouj/k9cC7LRLJFzCYu0vF
 9yiBPbpKqia6pFKJafluiLHemncpcP8dm0kXaS1I7kpMsPV1vIC8vLN7neRzLWh4Ie0qQll
 1o9EKnOtQOifSWzGhkEqNF9GtiRhJtJmLUK4ylMizob7GDgz0BBhaz6+ISxD5QCh/lkH6jb
 3zYbkTX52F/t6DXsgtmwQQoXP6JSsHH3DNBoXH/9uY0+YsPsNPUvIlrcMqhxP2MD0p5Goip
 GcNgJ9lA2Xgg9WKJW++gilfLu0GuRfGOn6RBTfj7Mg/WT93QL3IZ4VelMqPBKd/8PUAft6O
 3KblaHK4Vthv44m6cPMikWvDLapHjPdDPRTTqBcj3UJSd+TjJPRCtnAP0ZeyXKyP21IQ/tO
 odQpUXVyK+kkubC2mICH4cItyElOT9o5C1RP7XrwtJX60h0108ematmI5YLywcgodMHzS90
 1FcDWAAAOArUtYZD87piVtrxazqh3rM/3jPPcW+62lfpJ7K2P5uYLHcXaWiiuPeaftthsjy
 FH47AWKuklmbRoKEt6tCo6DNLdigm4ZTU4PFzZTVbSgVqCPepTkzRdK1G5jkknQZr8TVm/T
 ACGJFcNfQPisyvWEC63790QfJqnXb6JwC4v8NbyMFPKpEx5ij+a2v4syBITOwYjKQAyTHMe
 W9WKW5IOJkBdw+CTjMB7sjwB5Y/XNfnGQm1LsaP5D25vNW/U3suiYtkAGai4Z/BX6ZVwf6u
 PjyjyPepyElzNieJDquyIv1yxndzBewY5GMj1oEjsT4ITdMwoEpWIJ7YS8xVRN5xyc8E791
 4sytyg0GPANmRcnLqZ5Oaf2ZtWwhBK/oxYEtz42byPzAvAG7fHZKLHN9zdZaSSsW8lYZ/tF
 Exlz1JEzGbC5zHLzcaJxD7DIkJZM9zGG0rwt+4Ae6Cj3eGbXsRDycr+XctoYHsHQ+0TzILQ
 XW4i5DRZ0urhVRG3Fj1M5kU21ugNDew67PrfxuY0uM7k9wYjUsd3jzBflM2sxiAELjX/mQ6
 Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
> Sent: Wednesday, June 17, 2026 5:42 AM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; dev@dpdk.org
> Subject: Re: [PATCH v6 00/21] Wangxun Fixes
> 
> On Tue, 16 Jun 2026 20:20:08 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > This series fixes several issues found on Wangxun Emerald, Sapphire
> > and Amber-lite NICs, with a focus on link-related problems.
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
> AI review was mostly clean, do you want to change this one thing?
> 
> Review of [PATCH v6 00/21] net/{txgbe,ngbe} fixes from Zaiyu Wang
> 
> All findings from the v5 review are addressed:
> 
>   - 07/21: Tx desc free now loads the 32-bit headwb_mem atomically and
>     casts to uint16_t at the use site, removing the type pun.
>   - 14/21: kr_read_poll() switches from usleep() to usec_delay() to
>     match the rest of the txgbe base layer.
>   - 16/21: stray tab+space indent in txgbe_read_i2c_sff8636() is gone.
>   - 17/21: stray tab+space indent in txgbe_get_module_info() is gone.
>     TXGBE_SFF_DDM_IMPLEMENTED is now indented as a bit mask under the
>     8472_SWAP register definition, which reads correctly.
>   - 18/21: page is reset to 0 inside each iteration of the for loop so
>     it no longer accumulates across iterations.  The flat-memory check
>     is now driven by an explicit read of module byte 2 via
>     read_i2c_sff8636() into a local is_flat_mem flag, instead of
>     reading data[0x2] out of the caller's output buffer.  databyte is
>     cleared to 0 at the top of each loop body so the skipped-read
>     branch can no longer leak the previous iteration's value.
>   - 20/21: RTE_LIBRTE_SECURITY is corrected to RTE_LIB_SECURITY so the
>     !txq->using_ipsec guard is actually preprocessed in.
> 
> One small remaining comment on 18/21, not blocking.
> 
> Patch 18/21 (net/txgbe: fix get EEPROM operation)
> 
> Info: is_flat_mem has inverted semantics relative to its name, which is going to confuse
future
> maintainers.  SFF-8636 byte 2 bit 2
> ("Flat_mem") is 1 for flat-memory modules and 0 for paged-memory modules (this is the
same
> convention ethtool uses).  The new code treats the bit the opposite way:
> 
>   +	bool is_flat_mem = true;
>   ...
>   +		if (rdata & 0x4)
>   +			is_flat_mem = false;
>   ...
>   +			if (page == 0 || is_flat_mem) {
>   +				status = hw->phy.read_i2c_sff8636(hw, page, ...);
> 
> So when the module reports flat (bit set), is_flat_mem is set to false; when paged (bit
clear),
> is_flat_mem stays true.  The condition 'page == 0 || is_flat_mem' reads only page 0 in
the flat
> case and any page in the paged case, which is the right behavior, but the variable ends
up meaning
> "paged memory is OK to read" rather than "module is flat".  Suggest either:
> 
> 	bool is_flat_mem = false;
> 	if (rdata & 0x4)
> 		is_flat_mem = true;
> 	...
> 	if (page == 0 || !is_flat_mem) {
> 		...
> 	}
> 
> or renaming to allow_paged_reads (or similar) and keeping the existing default and
condition.
> 
> 
> 
Hi Stephen,
Thanks for your time. I will fix the issue as you suggested in v7 and send it shortly.


