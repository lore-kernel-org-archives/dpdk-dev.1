Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C98C282C6
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 21:37:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF3E440156;
	Mon,  3 Mar 2025 22:37:25 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 733BB40041
 for <dev@dpdk.org>; Mon,  3 Mar 2025 22:37:23 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 527B82110486; Mon,  3 Mar 2025 13:37:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 527B82110486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741037842;
 bh=wsb95SBmCip1yf0/F8cr6n6d6xxoUNZ/Pq+nCbBm3RM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nmL0mBk08pCVrCtLI+ZWK6fmgtdk6ZHmQ/YP7ufyJXcG1zvLIrPyvUOjsE7RII6y8
 WQOCEZuaZNQPEyQeIGcC8xYJaS/C4cBf4eUCElcIPJyfZP9AmCAqCXU4JbIwi5Kv1K
 e1RexGO9sGHttk2/t0kpJONKOIP0a8qbq7hWNPJo=
Date: Mon, 3 Mar 2025 13:37:22 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Cc: honnappa.nagarahalli@arm.com, dev@dpdk.org
Subject: Re: Segfault in rcu
Message-ID: <20250303213722.GA23080@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250301022622.GA6940@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAEYuUWCgT8DUyHvUdnDo1r1YisU2JYfctRCNaq=kFusXPe_nQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEYuUWCgT8DUyHvUdnDo1r1YisU2JYfctRCNaq=kFusXPe_nQg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Sat, Mar 01, 2025 at 10:35:48PM +0300, Dmitry Kozlyuk wrote:
> Hi Andre,
> 
> > @@ -386,7 +386,7 @@ rte_rcu_qsbr_dq_reclaim(struct rte_rcu_qsbr_dq *dq, unsigned int n,
> >
> >      cnt = 0;
> >
> > -    char data[dq->esize];
> > +    char *data = alloca(dq->esize);
> >      /* Check reader threads quiescent state and reclaim resources */
> >      while (cnt < n &&
> >          rte_ring_dequeue_bulk_elem_start(dq->r, &data,
> 
> In the last line, "&data" was equivalent to "data" when "data" was an array.
> This is no longer true when "data" is a pointer.
> Removing "&" fixes the issue.
> Maybe coccinelle can check for similar mistakes caused by mechanical
> replacement of VLA to alloca()?

That makes sense. Thanks Dmitry.
