Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51989CCD183
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 02:09:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01CD640A87;
	Fri, 17 Oct 2025 04:08:59 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id EDE1F40269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 04:08:56 +0200 (CEST)
X-QQ-mid: Yeas1t1760666930t068t64190
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.206.160.146])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 7556244160792311963
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>	<20251016111736.25372-1-zaiyuwang@trustnetic.com>
 <20251016095925.7490e5f3@hermes.local>
In-Reply-To: <20251016095925.7490e5f3@hermes.local>
Subject: RE: [PATCH v5 00/21] Wangxun new NIC support
Date: Fri, 17 Oct 2025 10:08:48 +0800
Message-ID: <000801dc3f0a$fa107e40$ee317ac0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKiC98C7jrCga9wsmi8xZSIVafTeAG5NHx5AYC6OC+zIC5m0A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NHu6THI/J1zc88dZfMw1QUmcgNyINZ6Twp/q0Id/0RPluXQOjo/ENTPa
 pfflLVVC10/iLd6RL7rfKApshoWSd9A0Z3UUD5IyXSKUmbb0uI6QVMLG22yZ326SGposcAs
 iUY2dWQ8lxrDAtVesDMenuxeZ8WOm4C+KZI68ktWkEM+BJHE6mWS/Q27bTCjPsQgic/qQmy
 iGE7ARNKWSVsyViMjB7FZyyrbCwptG3soVMoupBXFRdrLBbgmuPOKIYVIAnGC3sp0MQt0eN
 Rn4AKt324hwEL9X7aW1DlUfjYZ8d3YRjfhjx9NDKTJCPWSKE5rwgt1BxBM2/hKb7a513GEN
 Ws58bwWR8zlSD60Ij7P7rUrTSQzSvF38A+9VS15Gk99aQLwpeb1aEvOn3tpEolT9Ze40lUc
 xHxa0EtggpefsA59COMFStkWkJ0eJUTppbfv3AGEypeImzbdlUp9hXp6Q99ApONHSU307oo
 nVx1lu3TwBi1gX3gRnA2tMc7EaajUCINDHO+d3e4zH+qIbcMy3taXPqMAiLPzzpVPurh22T
 Www1QCK6oNaNtNXI4rUZYIVRW+wEJMvhZfnyB5hLVqyamrkE0Dv1DAcEvIEBLuDTlKsUejw
 yk1TyIjwYmu+YJfkp/VX4pQkkmvd7JVyjzHzqikr0VwQIiuS+JR6Vjg+T7xWV7Dqa51APOl
 OEgh4nFSxqE3jOt7TVsgGGtwt3XzBPkUPT7LyR4vogxqLiIe4pIoHRkikAFOu3gMMKSkmK5
 vPv4MCU7B8jdcmjavfhtrEQP+bKq+pdkVSWjZ7yAFKH32jCZNOPbpUXIQcBrUCQaOdYzw5q
 MBZFVROJsei7VrZrN56qqINCWEgDUr8REbDdWHEA3cmGSmPDrlLrICMzkehMZ86nVTeRneP
 FZPc0qD6xVk48jHbhv04h1dffDSmBFwmKdYUKJIYaKulzqf5CoET67OALXEmkdZVZcmQlVS
 f/RUniWAhwPcPupoxj49R13/jvSUeHCq8JosTz98odQ/QOINOafF4wZyjc6d5ggLhsFpU1v
 ghcsIRjrRWzqmOhrwT
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
> Sent: Friday, October 17, 2025 12:59 AM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org
> Subject: Re: [PATCH v5 00/21] Wangxun new NIC support
> 
> On Thu, 16 Oct 2025 19:17:14 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > We have released a new NIC series: Amber-Lite, with two models
> > supporting 10G/25G and 40G rates. Due to minimal hardware differences
> > from existing 10G NICs, it remains supported within the txgbe driver.
> >
> > ---
> > v5:
> >  - update txgbe guides, add more usage instructions
> >  - add a short summary into 25.11 release notes
> > ---
> >
> > Zaiyu Wang (21):
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
> >   doc: update for txgbe guides
> >   doc: update release notes for Wangxun txgbe driver
> >
> >  doc/guides/nics/txgbe.rst                 |  31 +-
> >  doc/guides/rel_notes/release_25_11.rst    |   7 +
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
> >  27 files changed, 1967 insertions(+), 202 deletions(-)  create mode
> > 100644 drivers/net/txgbe/base/txgbe_aml.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
> >  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h
> >
> 
> Queued to next-net.
> I changed the git commit subject to conform to the restrictions imposed by
> check-git-log.sh. Max line length of 60 and prefer "Rx" over "RX"
> 
Thank you for queuing the patch and fixing the nits.
I'll pay more attention to such details in future submissions.

