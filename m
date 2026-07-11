Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10ACC43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 23:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FF03402F0;
	Sun, 12 Jul 2026 01:14:50 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id D06484026F;
 Sun, 12 Jul 2026 01:14:48 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 32CD8EC008C;
 Sat, 11 Jul 2026 19:14:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sat, 11 Jul 2026 19:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783811688;
 x=1783898088; bh=mNorHogM4LsF9Z8O16FBU1svRgVKubDySUmP+LKzFbc=; b=
 PgV+eg9ZFZOkeZ/1Xv01CFQHPzVnZEtL6q5lepPaedIqP+EJaTG1MazbQW+6l4po
 xKgg2Qgb3z1TrUOMhU80Md6rDeoVb9lTcj/sC9mAXKwWJILh23TiJF+Xfja5C1Ov
 zdc73eIqd12X1XUMnkW9dKIqONpJnDNngK81d3quhDaYmo0LieB6wexcNtKgpAFt
 4mPGeuBqGpgIkn5XT71HMjAJS86WIIHkVrCLuAhT7dav8FNiaaElIK/1wusigYAr
 RncXwQVqj4QJ2Mot34CH2n8PVlad886KVDWrqpmK16lwB6ex6QVyo51tyiTP5B82
 WOcgFPMesWG2nbxqjZADMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783811688; x=
 1783898088; bh=mNorHogM4LsF9Z8O16FBU1svRgVKubDySUmP+LKzFbc=; b=T
 gAM+TeF2u98kDXLQgwpsgDkFjXPraorWIVH6xPGhDYjKt3zO8X5WR9u/9W49c5Gr
 mxFwfQjfBgQ8KJkZzCHHHNACyLLYGDb4p7UOGKczzrVCliaMKkE2gaJWSnerftvL
 aV4jCYArVX+8UEHpiDwGhLrJsUiAbd3WKF0VsIAWIyqWpMO64sBa+TYZWLghV6TK
 M7YxZyHWI9Zu9nXwaqLfbUX23YXCd0Ovaf8ut27o3FlkBg+2v8gW2UKQPP7fliEh
 1Kdd73eQReU1gy0elHbRRAgMQrEplcGDJuE9MzNqRacyM5GbgBqIm0p44NuYmGZA
 /XAxnydWs0AAbcJTiNZiA==
X-ME-Sender: <xms:Z85Sauqz6BuF2uYZ2eHQwO6WcMDRrJ6XgG9Kz_bmUGxv_60p3aDAHw>
 <xme:Z85Sams2vg080_z0T8iZ5vfj1t66Kv1PaGqCUc5FkbEFqIGuE9zIL3gK67dIAr68N
 ZLMfdQP7yhoX0gp3XVVkgofm_fE5uVQO_xK4GGC1UW7fhFxISC3PQ>
X-ME-Received: <xmr:Z85SajGpXyfhKeGLglxoK9tjQtqQsxmMyD_RHzV2V6JHt0_fh2ODHjbhsKjqwpkM-h84dL0zNTP56y_znw>
X-ME-Proxy-Cause: dmFkZTEjAtd9Zf7GLI578hDx2kmR4AM4SeFMNxmsl8FO6vY26C+fghDXYn2IZo9kMhc407
 eLjb9GQxWqQhUjWhAWb0EofkfM5pJJNjMSrXp93eG+U9OgA29X9Y22E/OnXQVHxD7g4BpB
 e77IAjMwDDPRBUxyXnAiaILSPj+Jb1tpitS4kSpieIbMteWnEM8ew9LWAIWnfnX+wFd3x8
 4jX40Z4rSz6FwZ1v7jADbFnGX1o0YR6As1FwUE/dMjKwRb2crGJUWC+V6dKUGlJw5QWw3P
 O/pvCLB+bUQrTkOhP53FutFt3h9mYlqyEJnzY8FiuLqqusjIYVnYSdoxXxjvYkbhK+0bAl
 RGZ+scv+UeqATZrKjiYr0OyixLBVp8pXZQWI20BNLWOURmygdUN3cdOVyBVy2roXvoPb1n
 UErETtY5oPal8wib1r0bodRUspGT5QyvNhDYHqvQLjgW6XIn8j0QiYhApk23X+yOfjImHn
 OCKLGxDwhyaJUkKVuCSJlwO3yuFN41bwOc8hHjtOFB7znXX0NgN6pRnUGTyD3DZtR69oal
 CpthF7ejso10sWn5ACTI75J4W8nGw1v8pwyKxe8InE0qBdaGGmceV6pWKLOb5ayH9CeXFu
 g19EOEnfbc5OAYtkjbJRZk1r8bE2v/VbEEH4a2M5P5nu9ABZ6VODQOkkgRgw
X-ME-Proxy: <xmx:Z85SavYKUrs-FW0mHZBnCPCgdLaXZxp0ZP6doc9fd9WHykRogmNXgw>
 <xmx:Z85SarVsHHr0fHHbqQ_kS5igDdckfT2CL1ed5DB9g9D9Zsd7_rLK_w>
 <xmx:Z85SatkEiimObtl402-oWVQCg3ZOBffcoFnDIhq3NpeBW_Cl3nyopg>
 <xmx:Z85SauCUaX7clMYlEsQdjUBzDDdiDgb19tPiH7wDt1z2lk7M_dIPXg>
 <xmx:aM5Saj5_3KI_YFN6AT-SDASDSEGyyYV54iBMzuULu6NiQaCoZgjd4JJ->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 19:14:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rupesh Chiluka <rchiluka@marvell.com>
Cc: dev@dpdk.org, stable@dpdk.org, honest.jiang@foxmail.com,
 gakhil@marvell.com, anoobj@marvell.com, ktejasree@marvell.com,
 fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v2] app/dma_perf: skip case if worker maps to main lcore
Date: Sun, 12 Jul 2026 01:14:43 +0200
Message-ID: <zvBuG0MvQ9O-GpS01tCxCQ@monjalon.net>
In-Reply-To: <02096633-cb82-4c04-9e39-00638146c11b@huawei.com>
References: <20260624045417.3294252-1-rchiluka@marvell.com>
 <20260624054254.3367097-1-rchiluka@marvell.com>
 <02096633-cb82-4c04-9e39-00638146c11b@huawei.com>
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

24/06/2026 08:09, fengchengwen:
> On 6/24/2026 1:42 PM, Rupesh Chiluka wrote:
> > When a configured worker lcore is same as EAL main lcore, the main
> > thread calls `rte_eal_remote_launch()` on itself and then waits for
> > `worker_info.ready_flag`. The worker function cannot run on the main
> > lcore while the main thread is blocked in that loop, and the test hangs.
> > 
> > Reject such cases early in the `run_test()`.
> > 
> > Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
> > CC: stable@dpdk.org
> > 
> > Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
> 
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.



