Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5FDD3B7EA
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 19:02:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51C9C4060F;
	Mon,  8 Dec 2025 20:02:16 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 95E0640395
 for <dev@dpdk.org>; Mon,  8 Dec 2025 20:02:14 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso24064235e9.2
 for <dev@dpdk.org>; Mon, 08 Dec 2025 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765220534;
 x=1765825334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfMErGJMioFBGTxaWN+PprkltEizSTpa2BC0MSekcMw=;
 b=CQ59U++O6sntUvFs/+La9h+knnoq2p0B76oMSjyuImWy9AWFdAK7rbseiX3r8COwXf
 C6yp7yKmYakJjmnvmyyr60xVIc7n9kgW574dra5ZjhSe7fkk5lv9OYTO8EC2kU73naS3
 gojvupwxLOylCHcm5A7441V/K8zTL/IC4a45a6pCp35NVEn0ALUJpgvIMAUHVBCJ3FKw
 fhCsywkHjeSXJQmy8QSuksmauoY07igZM2V6eRvJJYeItqDfBIXm35B13zoq7CBOnh/S
 wvJL5Gq064925G1Qv8hirg/UFHx1Q1E+0/uDWktzqU/lYFvcEpw9WXjknWb+tCf3VRK+
 fLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765220534; x=1765825334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rfMErGJMioFBGTxaWN+PprkltEizSTpa2BC0MSekcMw=;
 b=hb8s/PvTTu2drsUnK8tKa3ORlvaLRF2RBVMsyTlNn7buXUndWfcsbNgq30JjDJBSt6
 C5KBODf15CAcnEC8OY5vK0iQRysVjOMbI2biKBOc+48E49MKrVdevmrRN823mnNqVDTs
 +Ul/ljGUfrR59sHPlCJjvkJGjl21LSqDPvIFJONhtUWO6V+Vj6dYYB/ux+edYF8H+00j
 jzwZFSLGTSaE/vd8851D286uL3G4XKPx/fykXmNjpCzoiUYcjMSK62zSQB0aUdASUM3B
 kU1UMRUc8w0D85CLdN/s7T6x7z/RuVBeVI6m7e9tTdaoLHxzpXiNiRKNRRRZ8hZH/2se
 SAZg==
X-Gm-Message-State: AOJu0YzJKyk2b30yUcSYS6hpyc69L8BNK69Vi7FBvnngucH0ignVmT/b
 shsIYI6fsvUbG8WMprt+R1dgdbSIzouTMCP5a4wWcBa4gTnSIsz1yYTlZcXBEjtVu1k=
X-Gm-Gg: ASbGncvU5TLvt+4OunqSfTfiLLfWbO6Su5dTMhD44jGmIKMYu4B7TawxrpX3qmXZM38
 kChXqSG7hqtrmyooOkuB9pqdCzDzZmI3r3cs5xSPRw4+jrJmD8Ur2CGC+0Uhi7HRGG+kv445lQQ
 N8n+qEYCvVRDv1Je4+/sMo6u8rF60rfvc0e3CKSLmUdDov/PVFFOYhW8xiZboF00an+R3wvKoSt
 mfeG+y/0ht8AcDFPd9bSJnmaojhHs8gvmOuX7ToVbK3u9pZATrwLKpmOH8W8CeNKWsqnziZwwgQ
 gcCOc2+GELQ8YlcDD5oP2lKf5UjopxyW77cvp++hSWKRDu7VhlDEzhHmwCfizzLoDT5X4R/oIbs
 ga8IebBTwJzoN8vcLxDdZjLygOH42f1EDFDmSg0dSks5dZh4bKENQenN1WdZYZRNqmNQtxeaT4N
 awOrmLgbbGNl2MMv4znKLTAOYWud/l9RXOXt+dOgz50xV7PUoXFRlJEea4QcvsBxU=
X-Google-Smtp-Source: AGHT+IEE8bWH+IttnfSgBtDNhlEGOzHYf1Q7HUZw7zutdFt2TZpGG8rL33Ok5mlYe0+OqIv4+PBo1Q==
X-Received: by 2002:a05:600c:354d:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-47939e4a8e3mr100444635e9.31.1765220533620; 
 Mon, 08 Dec 2025 11:02:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d601e5bsm607845e9.3.2025.12.08.11.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 11:02:13 -0800 (PST)
Date: Mon, 8 Dec 2025 11:02:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yan Yanovsky <yan.yanovsky@catonetworks.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "qi.z.zhang@intel.com"
 <qi.z.zhang@intel.com>, "ciara.loftus@intel.com" <ciara.loftus@intel.com>
Subject: Re: Subject: [PATCH v3] af_xdp kick_tx() Retries instead of endless
 loop
Message-ID: <20251208110208.3f637bbe@phoenix.local>
In-Reply-To: <VI1PR03MB4144B177CE39B84E0DE3F01FF7A2A@VI1PR03MB4144.eurprd03.prod.outlook.com>
References: <VI1PR03MB4144B177CE39B84E0DE3F01FF7A2A@VI1PR03MB4144.eurprd03.prod.outlook.com>
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

On Mon, 8 Dec 2025 15:56:37 +0000
Yan Yanovsky <yan.yanovsky@catonetworks.com> wrote:

> From 191d90eaab50c6855ee746361e7e735572f3b1ce Mon Sep 17 00:00:00 2001
> From: Yan Yanovsky <yan.yanovsky@catonetworks.com>
> Date: Sun, 7 Dec 2025 18:10:45 +0200
> Subject: [PATCH v3] af_xdp kick_tx() Retries instead of endless loop
>  Signed-off-by: Yan Yanovsky <yan.yanovsky@catonetworks.com>
> 

Minor cosmetic changes needed.

>  drivers/net/af_xdp/rte_eth_af_xdp.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index b6ec9bf490..dc34f1a29e 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -80,6 +80,7 @@ RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);
>  #define ETH_AF_XDP_ETH_OVERHEAD		(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
>  
>  #define ETH_AF_XDP_MP_KEY "afxdp_mp_send_fds"
> +#define MAX_TX_KICK_TRIES	10
>  
>  static int afxdp_dev_count;
>  
> @@ -480,22 +481,29 @@ static void
>  kick_tx(struct pkt_tx_queue *txq, struct xsk_ring_cons *cq)
>  {
>  	struct xsk_umem_info *umem = txq->umem;
> +	int tries = 0;
>  

Unnecessary initialization

> +	/* Pull completion queue entries to free UMEM buffers */
>  	pull_umem_cq(umem, XSK_RING_CONS__DEFAULT_NUM_DESCS, cq);
>  
> -	if (tx_syscall_needed(&txq->tx))
> -		while (send(xsk_socket__fd(txq->pair->xsk), NULL,
> -			    0, MSG_DONTWAIT) < 0) {
> -			/* some thing unexpected */
> -			if (errno != EBUSY && errno != EAGAIN && errno != EINTR)
> -				break;
> +	if (!tx_syscall_needed(&txq->tx))
> +		return;
>  
> -			/* pull from completion queue to leave more space */
> -			if (errno == EAGAIN)
> +	for (tries = 0; tries < MAX_TX_KICK_TRIES; tries++) {

Suggest (but not required) to put definition here as:
	for (unsigned int tries = 0; tries < MAX_TX_KICK_TRIES; tries++) {

> +		if (send(xsk_socket__fd(txq->pair->xsk), NULL, 0,
> +				MSG_DONTWAIT) >= 0)
> +			break;
> +		if (errno != EBUSY && errno != EAGAIN && errno != EINTR)
> +			break;
> +
> +		if (errno == EAGAIN) {
> +			/* Kernel TX ring has no space or UMEM completion queue
> +			*  is lagging behind. Try pulling CQ to free room. */\
>  				pull_umem_cq(umem,

Do not put line continuation on the comment.
Original indent is better. I.e line up args on first to same column

> -					     XSK_RING_CONS__DEFAULT_NUM_DESCS,
> -					     cq);
> +						XSK_RING_CONS__DEFAULT_NUM_DESCS, 
> +						cq);
>  		}
> +	}
>  }
>  
>  #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)

Subject is repeated twice.
