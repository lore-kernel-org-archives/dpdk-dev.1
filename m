Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326EBCC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B0D640A81;
	Tue, 13 Oct 2026 17:12:11 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 59C0F40A7F
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:12:09 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so1576837a91.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791904328;
 x=1792509128; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mxEH76NjLnRX5QG6365s67rpE2ZkjSbwQKib0KBEARE=;
 b=XgWzQcs54EY3OuQeJFubXU/RSOrVn2rTNj/TC5TyrB5OViUP2gHcIAVakgmmuWdj/9
 Of2T/VkCz2ciury+KTKwdFf+DifA3IaS8czv9BbhyEtOY1V7yfsBVD7Z6On7g3ZCRsCJ
 Do9uSjtJQTEUpxXR0FTI0glS0gFKpAoqoo9ehnUcukgfvfGPWlljagbC6I4t2jWMbXPh
 xXpiGvJkeoR8C/z3fU+o175BlBQXYHiFQWNj0pgKLUnAzn/+Xqyf7+mG95IS9FyXj7/H
 4JbqxhADN1CugFGKp6w+anmWd6EfdQME0qDfIogIVgZ/YQKf/LwlrsE71DB9IIjVFF2a
 PfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904328; x=1792509128;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mxEH76NjLnRX5QG6365s67rpE2ZkjSbwQKib0KBEARE=;
 b=GT6AkhgH7tF9719QdK6/JsXa/TWcKAdAI0CQBfNs7lGir203jCIHTFNd5lzFKM9345
 v1PGlVfW7mXoaLgJx52qKciFci5SUvuqAR99GKKFNa4biagG6C45MkrAg9F7qU+/68Qu
 aBs9hdEnAvvcB1AurmDdjh+o+/ryBTm58okk7F3Ex4wIxokhI6/7uaYDS7RPu9R9eNCH
 1IH6jnd3AjbwFpsJ4QpRucaaDhFNHg3kUVG11Yk7VfbcmQ01/JMwLaGbBt2HFecLJx7A
 fBY7lPlM343WgTmcAbiSlcEUhey4esUz6lmEJW4apIJxmKxLXYPdfbNZEQx0u8oBZeHx
 oVLA==
X-Gm-Message-State: AFq9FYLhvTVXdFiQPsDZdjud8CClpNKs5TVNn3leuX3fEB7hBnjKMh2s
 xIkU1OuCld/GS3tbb0Ab+TUhLshlyy46wA3LrMl7fvFzuZS0SdelYKIbMueoEdSrW80LGmLbQZD
 oZMdPisg=
X-Gm-Gg: AYBFou2Y0fPCaHTKXv1D52SyoL3rHLSvV1t9SH7bbuzu9pBCLtTssrcK9Epd8Wqu5fG
 aZiXTlDXVmfTqU9SIJWorG8d+68o+In+8j2lJD6JURubN2/itHULnUDKjgSq8iouQ7NTCdIDl4Z
 gW3KWyNgUSS+fMcaWkL6q0uCauMPsyx2baSmBBqBMPt/j/zi7jDZFyHduAx9EJn6YPjW0TO76/Q
 SvymjEJTjo479ph+z6pwi9U/EM9PKezV1253UQS1z9hpMdyT/wrhW/3hNHi1myvKZCyB4lLKIFN
 OX3BCdDpxuXnAQReMbCXtWypjXEdLErDok591BQTEdYxMfXtm4NM/eeslPwnFf0G4wI43tfNE0I
 70jqRXigzOCYE8XskYSQqdcBYHoC0ypNJa3Ymi9/MCW5btVa2pIsqOWsBO0LL8dRZ+S+7P8UGtI
 rL81lm88FOd9G2KMEktpN3ioSr0/S/R8sVUAXRsYe7C5NjNLvJJ28V1zce5LBIUTS/rpXfqRQde
 2SWJ8EL0k7kioCENSKYG3wo4YcEy0/w83F52yIlEA==
X-Received: by 2002:a17:90b:1dd0:b0:3a8:272a:a32a with SMTP id
 98e67ed59e1d1-3ab3a9fc963mr10592089a91.40.1791904328190; 
 Tue, 13 Oct 2026 08:12:08 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f05083fsm35116a91.1.2026.10.13.08.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:12:07 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:52:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v9-S2 01/13] net/dpaa2: fix integer overflow in CCSR
 region mapping
Message-ID: <20261013075243.2903fa47@phoenix.local>
In-Reply-To: <20261012070444.2149617-2-prashant.gupta_3@nxp.com>
References: <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
 <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
 <20261012070444.2149617-2-prashant.gupta_3@nxp.com>
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

On Mon, 12 Oct 2026 12:34:32 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> From: Hemant Agrawal <hemant.agrawal@nxp.com>
> 
> In lsx_ccsr_map_region, PAGE_SIZE is a macro defined as
> sysconf(_SC_PAGESIZE), which returns a signed long and may be negative
> on error. The value was used directly in size_t comparisons and passed
> to mmap, causing an integer overflow (Coverity CID 49765682).
> 
> The old round-down "len & PAGE_MASK" ignored the in-page offset: for a
> 4096-byte or 6656-byte len on a 64K-page kernel the masked result is 0,
> causing the mapping to fail, where the old code would have bumped len up
> to PAGE_SIZE. The correct mapping size must cover the region from the
> page-aligned start through offset + len.
> 
> Fix by calling sysconf(_SC_PAGESIZE) explicitly into a signed long,
> checking for a non-positive return before use, computing page_mask from
> the verified value, and using RTE_ALIGN_CEIL(offset + len, page_size)
> for map_len so that the mmap covers the full requested region regardless
> of page size. The page-aligned start address and the back-pointer offset
> are both derived from the same page_mask, keeping the three values
> consistent.
> 
> Coverity issue: 49765682
> Fixes: f023d059769f ("net/dpaa2: support recycle loopback port")
> Cc: stable@dpdk.org
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
>  drivers/net/dpaa2/dpaa2_recycle.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
> index f78d12362e..9b6ae3f515 100644
> --- a/drivers/net/dpaa2/dpaa2_recycle.c
> +++ b/drivers/net/dpaa2/dpaa2_recycle.c
> @@ -176,6 +176,9 @@ static void *lsx_ccsr_map_region(uint64_t addr, size_t len)
>  	void *tmp;
>  	uint64_t start;
>  	uint64_t offset;
> +	uint64_t page_mask;
> +	long page_size;
> +	size_t map_len;
>  
>  	fd = open("/dev/mem", O_RDWR);

Does this driver work with CONFIG_STRICT_DEVMEM and CONFIG_IO_STRICT_DEVMEM?
Note it won't work in lockdown mode at all.

>  	if (fd < 0) {
> @@ -183,20 +186,24 @@ static void *lsx_ccsr_map_region(uint64_t addr, size_t len)
>  		return NULL;
>  	}
>  
> -	start = addr & PAGE_MASK;
> +	page_size = sysconf(_SC_PAGESIZE);
> +	if (page_size <= 0) {

Something is broken if this happens, should log it?

