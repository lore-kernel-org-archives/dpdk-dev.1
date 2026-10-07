Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD428CA600B
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:18:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F82E40294;
	Wed,  7 Oct 2026 23:17:59 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 7AD8F40265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:17:57 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id D58BE1D0016E
 for <dev@dpdk.org>; Wed,  7 Oct 2026 17:17:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 07 Oct 2026 17:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791407876;
 x=1791494276; bh=/3UUtVzl+EPX/HTEcNBfOwnfb7IHI1DBQVybkiVSNrw=; b=
 GB3uEzYxBi1p3u6ivxTeWR37jllIeJqSWi2I8J4dCKQkUy8CC14SIqQt+LJPtIc/
 WkmwcbLYl507i5cCUVV1bHLVNA912jwia8M6X6KCDA/Kwbmw6t5n+g4C1d7hZbeF
 iTOTZjUZqP/ORpa2Vvq/f9JIr5c7RBGRAg1IeBYFF52LtKzHMvRvAJdvMX2jyEIX
 SDkw+6J/aWQtwRap67xPNcohMxO3rjKoX5OybF8lBVGaGi2ltiAYJtTVupt6xVrw
 oWMjzB1sLPe6sMH/j1/o/aNdyyVZM2wQipSTKw/gxYC9O7Kri0AlHVH8DLaxtSu7
 oj1+ZOKhlSTMpVDs7s0kFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791407876; x=
 1791494276; bh=/3UUtVzl+EPX/HTEcNBfOwnfb7IHI1DBQVybkiVSNrw=; b=p
 pie4+n6LE2iAqTVeDrFvLCOvGccmifcWdYEhxLIm6QAwSAoiCUE5tdco8uYdqi0P
 lXj6HLvyqZmYFDQfu7/7bYCZu60oUCx2W3l/r+CqicTv+ECISz+vyrx9UGBbBBpo
 bimQ1x1egYudb7WScAAXRQ6/LpsWFlWmt97Mctr7L/aBSdqGiR+z//EKcPwo47uy
 wm+y5w/5QxV7ZDpRep14TFs4qWBJj0uvy92pzZUpr7pI5yOXNF5lIBB8HZDLplMF
 uFnZ1l2BrC0zuY6yznxJHOIAOZBKqIHHZXrT0uyc89Pt4/sUCt/F6SUO6f+dIikE
 cBU0BYpSF9+rmeRZaIYEw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791407876; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:FHqA6q+GeNU9VmtP0WGxqwZ5f8ExzDE0t2stnkqEExx66XK
 6Qgacu2Mpt834M3IrvTpfXjyBISp5X/CtBZin8+Q+HE06Fe/3XbM5eKpA66t0ESf
 jw5rg7rYt/cWJJAyvvEghMeWyXSTP1z+LceNKI4+cpx7upV0TKTjIjRq60s1syi0
 MKES0pYFJIoBLynea9KhW5sPnP0boVyytM8b8rZY3D73Co6sJSIZRRyytNKfwLH8
 NWWucpFhHF3ICVovWUvDotSEVUiyotwMwX81zgMJoZ+8Ho0qBZhg09iqMGMpnzjo
 2EVPRZouqq1ucHwoaZqt1LTq6IXFVytUfKJSERA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:X9Ph7tKw08miVADAD3IOcbXpLF/L6NJb3fa1DXtVMNw=:aQs4GxtOFzBp9Y6N/I/kMfgTfJi4VQOeTtwyuwQANzE=;
X-ME-Sender: <xms:BLfGakl_Da6Q_OvYYogeuR_zcarrDfseYaHbUWfZJoBmbm5PZTualQ>
 <xme:BLfGaoKz_n6wa6wg9dp6IsRBjBa3_2bg14eVEjjcLBOQ0Aye18Q-53-1oo3UbVHCF
 ZtRY3HPtBH8E6UHp1iVcEjjQOvBNOPexKx3k8gHls8S_tPVEKt5vIw>
X-ME-Received: <xmr:BLfGahztJfubHCHfKn3OThQJhFZMsWzkugw_dUxhfi5z-_xm1dkxFhatBbLciY01Rk2QhSSSjALfGRNFWWMoR44>
X-ME-Proxy-Cause: dmFkZTFmA6B/3hnseugnem9OpXu3BcfyvF+SrusuMvOJ6QVq4twYVwVrody8BidJWPwqyK
 W8sNY+aRZwxsjZFwS3LoBLDTw02DQmG3xcYudg5BSAq6SZscYIpdWkE0J9Oy7cqMKR35eW
 vj7ckdLhKLLUyy0iU1R7TH5Ks3nGhMBsvCCTI5AL0c9rtZH9i0I4GLhALOgsg5XNSvCEMI
 ygwiim8Rxswh3HJNNC3DJ9giaFfHBwd+oAo7SrLm8efenD/5sdm+nGhI1KQyMfgbwVAl0R
 Dl2CrkZJwEfonqG4UnkSJZgKVZrO+epWUai/qhBDFUdTsx2bVK7A4/cwCyav+Lgh7j5GZE
 vpD9MU2VGYfzuzhguMedZv/5T0Pz62zhG7tUyFnpzjc4SbZmtvE/H++cuA3Rl961cyEUo6
 xrRzBNrPvgci7Zv7RMsjtXKMlVNdePgSSO0NzCC1r8Mhii5OCcpriAPL3y6CohVcg6KSq/
 LtOYdIV43KaQc3N5AmOM9x3A0KTuK08LkcqGCN/Iya4a98h88qJ+TKRZlsR26EIN5XBVzF
 GCVxhJYIhtWgzxiVYSdi1BlagYcOh7BwtQYtYPx27F8TdYNUSCybPmd5af3KqlPeyL7RZD
 4styGf3yZwP4cVu8WnjVae2uMDpEPCOBnvqxV5w/+cQ1gd+XcWQS6Mar4ofA
X-ME-Proxy: <xmx:BLfGaosUz5H91BpVWhjRtlHvXFGzCaPFxXWZ5G5J-6KY22p06N8GDg>
 <xmx:BLfGaoupQtASXn5ryOy2nkwLYOotUOAoYvofDatj6-f3Fem9O98dhw>
 <xmx:BLfGatOVo0_gCDa2yPQXxjtOr7kUWnSZc6qPt0ZoKPLTChIwby1s1g>
 <xmx:BLfGam3YJ2SHim-bcc5I-x9WsHyq8QFvbtLlylxikKJlokCVeTL0-A>
 <xmx:BLfGagAygHLOyMs-mlRAR4HJ5dXWtHFwfHSICvbuH19S0w6-6iqEIKCG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 17:17:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH 0/2] eal: notify secondaries on primary exit
Date: Wed, 07 Oct 2026 23:17:53 +0200
Message-ID: <EmFyQLKjR4ynSjBaPSOeMw@monjalon.net>
In-Reply-To: <20260618090940.6853e9cb@phoenix.local>
References: <20260507210152.410419-1-stephen@networkplumber.org>
 <20260618090940.6853e9cb@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

18/06/2026 18:09, Stephen Hemminger:
> On Thu,  7 May 2026 13:58:35 -0700
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
> > Bugzilla 1942: when a primary process exits cleanly, secondary
> > processes other than testpmd do not get notified.  The notification
> > mechanism added in 25.11 was placed in testpmd and used
> > rte_mp_request_sync() with a testpmd-specific action name, so any
> > non-testpmd secondary (dpdk-dumpcap, dpdk-pdump, dpdk-procinfo, or
> > out-of-tree consumers) would log "Cannot find action: mp_testpmd"
> > and the primary would block on the 5 second request timeout.
> > 
> > Putting application-specific IPC actions on a broadcast request path
> > is the wrong layer.  Notification of primary exit is something every
> > secondary needs and should come from EAL, not from each application.
> > 
> > Patch 1 reverts the testpmd-side mechanism (commit f96273c8e9d3).
> > The secondary-side primary alive monitor (enable_primary_monitor)
> > is preserved and continues to handle detection of primary exit via
> > the existing alarm-based polling of rte_eal_primary_proc_alive().
> > 
> > Patch 2 adds a generic EAL-level notification.  On primary cleanup,
> > rte_mp_channel_cleanup() broadcasts an MP_REQ_QUIT message to all
> > known secondaries via rte_mp_sendmsg().  Secondaries register an
> > internal action handler that tears down their own MP channel on
> > receipt.  No new public API; no application changes required for
> > any secondary, in-tree or out.
> > 
> > This is the minimum fix suitable for backport to 25.11 stable.
> > It addresses the clean exit case.  The crash case (primary killed
> > or signaled) continues to be handled by the existing
> > rte_eal_primary_proc_alive() polling on the secondary side, which
> > detects the primary's release of the config file lock.
> > 
> > A more complete solution using a connected socket type (SOCK_SEQPACKET)
> > is planned since that can handle both planned and forced exiting
> > of the primary.
> > 
> > Tested with testpmd (primary) and dpdk-dumpcap, dpdk-pdump,
> > dpdk-procinfo (secondaries).
> > 
> > 
> > Stephen Hemminger (2):
> >   Revert "app/testpmd: stop forwarding in secondary process"
> >   eal: notify secondary on primary exit
> > 
> >  app/test-pmd/testpmd.c           | 103 ++-----------------------------
> >  lib/eal/common/eal_common_proc.c |  51 ++++++++++++++-
> >  2 files changed, 53 insertions(+), 101 deletions(-)
> > 
> 
> This is a real bug fix. Even if AI is being overly wordy in describing
> it; what it does is move the notification from being testpmd -> testpmd only
> to a more general primary -> secondary mechanism.
> 
> Without it can demonstrate the bug rather trivially with packet
> capture tools (pdump or dumpcap)
> 
> Could this get reviewed?

Anatoly reviewed.
Applied, thanks.


