Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82B3C9832F
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Sep 2026 16:58:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F99840613;
	Sat, 26 Sep 2026 18:58:45 +0200 (CEST)
Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com
 [74.125.227.169])
 by mails.dpdk.org (Postfix) with ESMTP id 24154402A4
 for <dev@dpdk.org>; Sat, 26 Sep 2026 18:58:44 +0200 (CEST)
Received: by mail-pj2-f41.google.com with SMTP id
 98e67ed59e1d1-3a0aa9d356eso1460450a91.0
 for <dev@dpdk.org>; Sat, 26 Sep 2026 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790441923;
 x=1791046723; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UletCJLL++YTy660vMofSse0weGj2Im3qTdlnNhfJCQ=;
 b=jwamb62L4SFIWp1VLeUeK/XL5/w1BaW0dD0On8kJC6IK1UaFluFAxqzaIhfz/eZz5l
 nKc5ljeXdf+hByP38rCz1IVv25a3pH6I88KGsrdwfvSzz0tKtodkV/sCMBRlfuEJ/b4I
 +OrVVNcGwNCLvVKcRPGO+m3s5fbMw2+L+1eWEL92bltQnaIceXI84av05UP2IAPEAETt
 xQI2w4yCvq3G60xz8O0DSMbYF3ngAtoc1qMGA5rXBn+gZMkgn82MYhsl6N3Mq9N+EIEK
 1JNx+QtWYOCxk5zWC0jTW+jQRJzh7PyifSJOKytya7KJcWQ2aBYo4tfxKQfBOis/eFtE
 D+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790441923; x=1791046723;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UletCJLL++YTy660vMofSse0weGj2Im3qTdlnNhfJCQ=;
 b=YlDDy7NEBW51blTj9VRLmLAxhi/SwbNGcFGzSBYcBncF2ar/7LRQphtZ4JJaiN6eUr
 ABBqnrYH1xQAPaPMpugAqLIv6hGIJ6LTpho7eoh9OIH5v7wc209Pz4IMlnkJaxqvlCQM
 YapaJUYh+aw8Qf89+NfyKQjpn7HTaI891w2wXDlnEAtW5jYmAgsA6AesQaBA9PKtvpXx
 QaD/GVvLGXitIy7DSEDfzmbMKjBNpHeC3+n1XB1X2m4w7EKK1k8KAQ1qqMRs5wYOeUrU
 GXGiaQh++jbm/q0gDjbjckTgIkOWAk3WISFT8CJc3hUaGxq0/ymmqDJtTR0wKS+Mi5je
 hpwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOqY1fkgz9Gwjjh3s1eEovrZvRqQT2YXfBTRKTLKCo8kNRZR0XUsjF4Q8zbnB27uc7Vgc=@dpdk.org
X-Gm-Message-State: AFq9FYIIyoUiUySJiEtfxomiqgSfnQdftR2X0WbB6qXpLoSTxvBsNLgx
 lW/dg9HnRfvRlKvDjaA56wUnnGxPFNkrkdHmDIIEjJT6RIoJ+7rMJzpT/+eyNckemuA=
X-Gm-Gg: AYBFou29Xozkb1Hh79tjf7sVjLjNHAv+o0TUlTZ0gV0IylIxgmf441KT875rc5YSQ55
 dDG9VAmbvcKuFihtxW4T0w3IC6wgOVPCQqTM7pPu+Oa6H59GGJ+z/sZM/QIzBKQttDZahM3bHzt
 UeQm0TImP5yfoiSnnoBVEayqa7BsNtkaDUr9Aq5p8dLv1sU4lR7aSWL0RmM0nWGfNxcva/Ke3gR
 TwiI1oXSNC17Xf8qLiaax47SVUcJEo9tNr7K3V3s5KEh86LOM2+Bb/Gq5wT9ijGICmbjLmVFgF8
 ZlS8sEmYiHWTyQN0ISKGB3iIcrcjaJwSRqUgB1NK+4dNfrJXQ+COJnQTWceq3gDNqur+vYUHjyk
 zDh9NMC0v1B5OQSyLhxrEU4lRMDHqi6s3YbbmOhjDAmEM8JfYhJgW6lPkH28COqEWpKD0Ek2OaE
 xW+G9YASSLZLa4EGZtHIcaQ08BfkyjQWdVb7wglVMFAOuWVZWBZebWITdUaseXHO2hX02CC69TK
 ULkPcfarhsVhDKPvuNB/qRsu+oH3hHqIO1Pqi58
X-Received: by 2002:a17:90b:4b86:b0:3a0:ea9b:1e38 with SMTP id
 98e67ed59e1d1-3a0ea9b31d0mr1404724a91.27.1790441923076; 
 Sat, 26 Sep 2026 09:58:43 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b99e5220sm10520147a91.16.2026.09.26.09.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 09:58:42 -0700 (PDT)
Date: Sat, 26 Sep 2026 09:58:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>
Cc: Jeroen de Borst <jeroendb@google.com>, Rushil Gupta
 <rushilg@google.com>, Joshua Washington <joshwash@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/gve: fix redundant comparison of qpl_bufs with null
Message-ID: <20260926095840.01090b84@phoenix.local>
In-Reply-To: <20260925131641.3895495-1-Alexander.Konyukhov@kaspersky.com>
References: <20260925131641.3895495-1-Alexander.Konyukhov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 25 Sep 2026 16:16:41 +0300
Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com> wrote:

> Memory allocation for qpl->mz and qpl->qpl_bufs occurs in the
> gve_alloc_queue_page_list() function under the condition
> if(is_rx) qpl_bufs = rte_zmalloc else mz = gve_alloc_using_mz.
> Accordingly, if qpl->mz == NULL, then memory allocation
> for qpl->qpl_bufs definitely occurred. That is, in line
> gve_ethdev.c:127, an additional check if (qpl->qpl_bufs)
> is not required.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 9873a135bfba ("net/gve: allocate Rx QPL pages using malloc")
> Cc: pkaligineedi@google.com
> 
> Signed-off-by: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>
> ---

NAK

AI review with better tooling finds this patch is bogus.

Review: [PATCH] net/gve: fix redundant comparison of qpl_bufs with null
Patchwork 170040

Error
-----

The premise of the patch is wrong. mz and qpl_bufs are members of an
anonymous union in struct gve_queue_page_list (gve_ethdev.h:76):

	union {
		const struct rte_memzone *mz; /* memzone allocated for TX queue */
		void **qpl_bufs; /* RX qpl-buffer list allocated using malloc*/
	};

They are the same word. That is what SVACE is reporting: in the else
branch qpl->mz == NULL already means qpl->qpl_bufs == NULL, so the
test is always false. The commit message has this backwards; the
allocation logic in gve_alloc_queue_page_list() is not what makes the
comparison redundant.

After the patch:

	} else {
		uint32_t i;

		for (i = 0; i < qpl->num_entries; i++)
			rte_free(qpl->qpl_bufs[i]);

qpl->qpl_bufs is NULL in that branch, so every iteration dereferences
NULL. The branch is unreachable today (a successful alloc always leaves
the union non-NULL), so runtime behaviour is unchanged, but the patch
codifies a wrong reading of the struct and leaves the real bug in place
(see Info). Not a fix. Should be replaced by the union removal below.

Warning
-------

Fixes: 9873a135bfba does not exist in the upstream tree. The commit
"net/gve: allocate Rx QPL pages using malloc" is a71168a775e6 (v25.03).
Cc: stable@dpdk.org is on the mail but not in the commit body.

Info (pre-existing, introduced by a71168a775e6, not by this patch)
------------------------------------------------------------------

Because of the union, gve_free_queue_page_list() never frees Rx pages.
For an Rx QPL, qpl_bufs is non-NULL, so qpl->mz reads non-NULL and the
first branch runs:

	if (qpl->mz) {
		rte_memzone_free(qpl->mz);
		qpl->mz = NULL;

rte_memzone_free() is handed the rte_zmalloc'd pointer array;
rte_fbarray_find_idx() rejects it, the call returns -EINVAL (ignored),
and qpl->mz = NULL also clears qpl_bufs. The following
if (qpl->qpl_bufs) is then false. Every 4K page from
gve_alloc_using_malloc() and the qpl_bufs array itself leak on each Rx
queue release / teardown, and the per-page free loop is dead code.

Fix is to drop the union so the two pointers are independent:

	dma_addr_t *page_buses; /* the dma addrs of the pages */
	const struct rte_memzone *mz; /* Tx: memzone backing the pages */
	void **qpl_bufs;              /* Rx: per-page buffers from rte_malloc */

and simplify the free path:

	if (qpl->mz) {
		rte_memzone_free(qpl->mz);
		qpl->mz = NULL;
	}
	if (qpl->qpl_bufs) {
		for (i = 0; i < qpl->num_entries; i++)
			rte_free(qpl->qpl_bufs[i]);
		rte_free(qpl->qpl_bufs);
		qpl->qpl_bufs = NULL;
	}

Costs 8 bytes per QPL. That fix is the one that should carry the
Fixes: a71168a775e6 tag and Cc: stable@dpdk.org, since v25.03 and later
leak Rx QPL memory.

Review-Result: ERROR
