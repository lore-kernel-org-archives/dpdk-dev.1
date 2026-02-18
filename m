Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65547E9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 18:21:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71D0740269;
	Wed, 18 Feb 2026 19:21:03 +0100 (CET)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by mails.dpdk.org (Postfix) with ESMTP id C17D94014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 19:21:02 +0100 (CET)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-45f126d47b8so56954b6e.2
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771438862;
 x=1772043662; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/PtNNQ1jNYXGQUr5/+cHRMVkxDPc7fMg/NktbFRu0A=;
 b=pkQ/DMZS0mUzqPJoiVqTkZ37aqMvIZHRM6JmS9zCYSQpfEtGGq6aYf31uYyEdpxNJP
 kf4tJEtrIHdQwQvrGO/LIWlLWZUR4hW1rbfUUve1fUsnGiRWYeiN9Ronz/mh+//95kFN
 RfUC/AJhovn83dgONhz1B23vphzS9ipD4FRURzkX7HRbCp6x5exL10+eCLq7fL7qxYXH
 zX8AvxpdIkd0VRAKBMurGepDaDAVc+Vn9ko+5QdItsZjWtJPu32lzh5O9rOHAuhP2Lz0
 hla3Yn+yIeFQdXoFXDzZpuBRpQItadl+yTRvlsqQFXCxIAYT/PUmG8SpBBtOAyxWzxgk
 qf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771438862; x=1772043662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y/PtNNQ1jNYXGQUr5/+cHRMVkxDPc7fMg/NktbFRu0A=;
 b=wh7LncmFcTNvUC7X0T5ylCsp15JXplSJFyroGokHn+H7idH/DPcss7Ce8rGLGS+CuT
 PVduKEYxHawKVOpjLuUKXnDAPcb2TimqZtTjAJoq0uyK2EBeSvrYk3+G0OIQ8Pefzvpu
 C/JrgKxwJbb44EHvkbR/s24RBVtKwFEqkk2finUVR00vMZnhuptTpuijkolmgzUsf8x9
 wODMYcW0AEfVzz2P2gao9JtvWPFVPUwZTusTQHSSKv55/lPckhOGOlW0+NOrmlf+BCM7
 YkV56Tr1RIZd+oOWbiRY3SbcJhSjNaDJNVKuJiv+HXrHgPkj05/MAh6JQskOtUxr0C5f
 Xi5Q==
X-Gm-Message-State: AOJu0YwOapUMsAvbThlImQTYBa89i33HdgnN/XpMczTWKJh6UBdevqEs
 Nzaj1MJizllIW5nk/BMmckxlkMpaQZ+VIrATV2riDny7ysy2X6584TUDQok5/ajtfyM=
X-Gm-Gg: AZuq6aIt7SrQvoJZZUQSTVBMThN+vP8tbE5AlPfZdjNtdkyJY8ybJJ+q6uFhltFT3jR
 7iZqZHCzaLkE38SFOms5qmejM1zc5lQ+HYxEYxHUFebcP3x7mtqXADB/Y0NjvWegR/0vbiA9G7T
 3Nb0h3PL630h+OZXjHAi62DGoukC0tjpzaT42ZT1qALBg8k5JlazAf89LqwAMtxVr4eu0jG0nw6
 bVbWsQSchx9bd9T3V8S1Su/NECNh6KcYgWk8LRcDP1K9dVYBXFfJDTqScA3YbY9vQ8EBbbph2je
 3veoXdOWgGb1QEQFrnsqMPhCznLEyIjYKVUNnjtwtMBv72oQUPIOckrcY3Q2scaMEucaLuHdJqC
 r/cmDDPjTuZY3QYUkFWM+Aznzw08CrwUJYbwYqeMViFK3iDZdb4KY2kb0qBCQ7+rTI36wie2AIk
 Wq5stUR+qg8KZeWXlF4SiHPMBN65wdFo3FaM+t7i4KxrTItoSUuJe0V912Hqk/UyU7RlsAaS4vr
 6g=
X-Received: by 2002:a05:6808:1a15:b0:45f:1ce9:3ade with SMTP id
 5614622812f47-463b3f615e7mr7622452b6e.19.1771438861771; 
 Wed, 18 Feb 2026 10:21:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-463b83bb884sm10070434b6e.11.2026.02.18.10.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 10:21:01 -0800 (PST)
Date: Wed, 18 Feb 2026 10:20:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH 5/7] net/nfb: support setting Rx MTU
Message-ID: <20260218102058.53296e9e@phoenix.local>
In-Reply-To: <20260206170435.302184-6-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
 <20260206170435.302184-6-spinler@cesnet.cz>
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

On Fri,  6 Feb 2026 18:04:33 +0100
spinler@cesnet.cz wrote:

> +static int
> +nfb_eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
> +{
> +	unsigned int i;
> +	struct nc_rxmac_status status;
> +	struct pmd_internals *intl = dev->process_private;
> +	uint16_t frame_length_max_capable;
> +
> +	mtu += RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN;
> +

Since mtu is 16 bit value, you need to use uint32_t to avoid
overflow.

Something like:
+	uint32_t frame_len = (uint32_t)mtu + RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN;
+	if (frame_len > priv->frame_len_max_cap)
+		return -EINVAL;

+	for (i = 0; i < intl->max_rxmac; ++i)
+		nc_rxmac_set_frame_length(intl->rxmac[i], frame_len, RXMAC_FRAME_LENGTH_MAX);
