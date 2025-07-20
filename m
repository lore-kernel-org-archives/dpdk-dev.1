Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADFBC83F1A
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 13:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F93F4021E;
	Sun, 20 Jul 2025 15:14:51 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 068254014F
 for <dev@dpdk.org>; Sun, 20 Jul 2025 15:14:50 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 319801D00153;
 Sun, 20 Jul 2025 09:14:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 20 Jul 2025 09:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753017289;
 x=1753103689; bh=iBqL6mE5y1kVfsjd5V7bt0EUYbEeSbDKS7iXM+c9jXA=; b=
 txVflIXrMUkXcK62ZyAWAx3lxDCpkYYIcAecyxOfPPNTmYybWr5mjFlYmlanUkx+
 tiA6df+rm4YZ30HV05JqcUKLAJ7IrruMJsLC9YpE2SNkJSC+Cy3L5LpWMr681BSX
 dqo9plsAsqKvHqvTgj+gvlQSII//f+gsjNDB0dDur6XWCRhuu0Su7dqoFjcq84O2
 z3zXOqgA/7BqQPx2xua1A+4cTsTbZstlAcLQgipKLIh0LmqG62TutQ2v7axji1a2
 oB99F8O+pQ8sr0mytgpnv/GhmRMOMQSGwLbHAJ9wQTHRBRxzytVvf2i8xAsfF8X7
 ZGoSgbhGPSRbEDKi4an+Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753017289; x=
 1753103689; bh=iBqL6mE5y1kVfsjd5V7bt0EUYbEeSbDKS7iXM+c9jXA=; b=B
 L4qDXPtE7G7bK9Z99vN5zhRp35BoXePsqlVjhMYFQ44QzpmZBVPXHRPUec5VNf0L
 VQiQjPm9oA8GF610l/oONfWv6SCj4w2u364Bn1X8t4Rh+rpZ5N+v/A4T+u6cnJgT
 t7mlWlVwLgS2SxrcvmGr26OHssTVzPOES0JhhvxSSciVmZc1RWTbumVyQgc5nYUy
 7S78kUFPMCM51wXe2FEN2qJoLq0y4cbOKK9AuguSbf4VG75/KoEPTf0eS1S9t0V6
 KdjGYdVAWtM5vYXGyaabQpWaWpWRDH1kPFWWH4yLZdXetlp68QZmlgbb5GKUGs0T
 bX5XX3T/zfjAhsHymJpTg==
X-ME-Sender: <xms:yOt8aPawg5GILJvrodj4v8grvZtq1THKqORKbVbRc28NnmKa8WMPAg>
 <xme:yOt8aDxwwkQu_NjYy7d0uYvDKHgTrBkOpuzNklXcNI_8tfaDpkIbl_xvu_4w7MJVK
 OcrKZ2gaMgZxXV2Cg>
X-ME-Received: <xmr:yOt8aCKYHJLt9sJzictlnnFdXfHIxHEI-IcQm3moULOqrNdKNU4vHq_it7wD-dVGPZYAkNALQ4KBjD3MmHeKcxARUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeileeftdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhonhhglhhisehmihgtrhhoshhofhhtrd
 gtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdho
 rhhgpdhrtghpthhtohepfigvhhesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhope
 gurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhg
X-ME-Proxy: <xmx:yOt8aFrlRUXDbmteJ6C6BJ78QR8JcyDmAnPKw8VtLLbikp7aoROrsw>
 <xmx:yOt8aJKtaktFn-AHS8VPDEWHaNW09hnRm8M7WbuYRtYcLOPImY6vQQ>
 <xmx:yOt8aCTQCsgAzLTmWGihSee5YGejp3ZPVvStellIUDH-7KsTzfvWPw>
 <xmx:yOt8aAtRxwB2bM8mJ5ZuFgfzAoJsYwxhIN4GC3x6KvcOGg80moDV1g>
 <xmx:yet8aF-7YBOrfY92Pp1L5jLSQ_1LynYyN2GVCY2JwxyXCYPG9A70obp8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 09:14:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Long Li <longli@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>, David Marchand <david.marchand@redhat.com>,
 dev@dpdk.org
Subject: Re: [PATCH] doc: remove the public interfaces from bus/vmbus
Date: Sun, 20 Jul 2025 15:14:45 +0200
Message-ID: <3562151.QJadu78ljV@thomas>
In-Reply-To: <1748910704-25463-1-git-send-email-longli@linuxonhyperv.com>
References: <1748910704-25463-1-git-send-email-longli@linuxonhyperv.com>
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

03/06/2025 02:31, longli@linuxonhyperv.com:
> From: Long Li <longli@microsoft.com>
> 
> The deprecation notice has been sent in
> 7642e3b0e0 ("doc: announce vmbus API deprecation")
> 
> Remove those interfaces in this release.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  doc/guides/rel_notes/release_25_07.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> index 6b070801de..672307da6c 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -125,7 +125,8 @@ ABI Changes
>     Also, make sure to start the actual text at the margin.
>     =======================================================
>  
> -* No ABI change that would break compatibility with 24.11.
> +* All the vmbus interfaces defined in ``drivers/bus/vmbus/rte_bus_vmbus.h``
> +  become internal to DPDK.

This must be part of the patch changing the code efectively.



