Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2903E87834
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 14:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FED54029D;
	Tue,  3 Feb 2026 15:14:05 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 939B34013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 15:14:03 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-432d2670932so5109625f8f.2
 for <dev@dpdk.org>; Tue, 03 Feb 2026 06:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770128043;
 x=1770732843; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Db6G7MyHqvnHKSQY+tRdKQwsyN9UrQD9VnkqvDP7rk=;
 b=l5EAryRqz8dc/HH6xf8+faSZaP85Bsx8iHZb1fZkP2JGyx76FgwvCmiSHESKI8CFgs
 yMyoj6N3ZCiVRzxO7K48FGddgKYQla6gD9G9wfeyQ6BlPWDhe+xHXteqJuxrEQKztqq5
 wlDVYaREfB/CEVPNdCJxlq2jMgrb3LNInVMRe5ntqL4IGYx0+NAZ1FlKwDBu9n02ZjcT
 0FfArzjktPQu/pIreNMSJvMT0kPc/EETC6xyjUFvHg9NClafkBH0Vb48FT8Dwc4G8p9X
 x4vikhsZBUYnqjRjT/UjVqe+SwhFMp+IrlYD+0nGZIpN33qEEmT4VHnVwnPeXlvD61s9
 wcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770128043; x=1770732843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Db6G7MyHqvnHKSQY+tRdKQwsyN9UrQD9VnkqvDP7rk=;
 b=e2bzP+zSvzIuyy+7qF97lyWq5lsdJLpm1fdDoBu4H369zd33r6uC50EcO+gJ9vXDT1
 bQloEC3zkseVvRLoaWtXWzGBb7Iq9UaA0fErfQxgj/QWb/sXnSVWDAbaLSREEL8g0uHQ
 o3V4b8GUkwu1U3d47bkXR3rkgQakql2RG5N20jcgL+3bRNS+bzSBHs2MOVUvnEQ2r+A7
 QT6sJHa4bqxVR+370nWd2FWQO145fijvk6JByMT8V+Nk2JV6dG4gck5h9Fe6XPwVvh86
 wn5GyaqEE2EsVQX0Nl9tiYP+NXj6NwwPPC4locS49g/EG1+zNE8T4Dj+k5o82+Mkeqp0
 7FcQ==
X-Gm-Message-State: AOJu0Yy/befNwt1SCr68xQahFRmP4PRiO2Cn5GBoO347qw9xt061dGLY
 n81w/+BCbzZctp90sOndzel5YWwRaCjrVrMNozn/8bYZXAmPDgsNelsv4e3c7HHhk9o=
X-Gm-Gg: AZuq6aLLo3C6PbWllR9WwNUplp2WTc9t//uLlfQgMi+QyRTIbOQR1BmzNFE0VjrVNOB
 gHNFur3IQx4hz5pbEiu0a8IMkYLrP9gKVQCPn7yuC2pCZ32N/PQ9XtnBsgtE/oyUOb84Gh200j7
 UDz4TlGwcWMcbW5HeXYwX1DehvVmjI1J1rqNlbyg6FO9Tj/gJYsN9nP8JTe3upcKaBfV0ZQetwJ
 8n2XZGpT9h8fFEehM+TG9+8XGuK91Ntud9Rt3YGBt8eUIq7r7x61IDx03OWhpdP171TpVQhSXUR
 MyaaRopacATdcjom8QFr/RnSqwlpj5gQkdPA7byBbLtCmqo0wSdgeJxYgUNzN8ujn/3m2jeFZ24
 lTM+xB0228RN43+eX/TMpjkpstebOofQqbRp96O9O22t58el/ZVo3VEt+992D4mMWmuK7sqx+/K
 b3Vn/hNn72FWFCxa5C2i4t+mqdImEThZai3pe/9a62FuQvJHXeuMeE
X-Received: by 2002:a05:6000:2905:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-435f3aaa63fmr23306656f8f.39.1770128042909; 
 Tue, 03 Feb 2026 06:14:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce58sm51115769f8f.20.2026.02.03.06.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:14:02 -0800 (PST)
Date: Tue, 3 Feb 2026 06:13:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 4/4] net/af_packet: add software checksum offload
 support
Message-ID: <20260203061358.381ec977@phoenix.local>
In-Reply-To: <20260203070740.62305-5-scott.k.mitch1@gmail.com>
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-5-scott.k.mitch1@gmail.com>
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

On Mon,  2 Feb 2026 23:07:40 -0800
scott.k.mitch1@gmail.com wrote:

>  
> +/**
> + * Compute IP and L4 checksums in software for mbufs with
> + * RTE_MBUF_F_TX_IP_CKSUM, RTE_MBUF_F_TX_UDP_CKSUM, or
> + * RTE_MBUF_F_TX_TCP_CKSUM offload flags set.
> + *
> + * On success, this function takes ownership of the input mbuf. The mbuf may be
> + * modified in-place (for direct, non-shared mbufs) or a new mbuf chain may be
> + * created (for indirect/shared mbufs) with the original becoming part of the chain.
> + *
> + * @param mbuf
> + *   The packet mbuf to checksum.
> + * @return
> + *   - On success: pointer to mbuf with checksums computed (may be same as input
> + *     or a new mbuf chain). Caller must free only this returned pointer; the input
> + *     mbuf pointer should not be freed separately as it may be part of the returned
> + *     chain or may be the same as the returned pointer.
> + *   - On error: NULL. Original mbuf remains valid and owned by caller.
> + */
> +__rte_experimental
> +struct rte_mbuf *
> +rte_net_ip_udptcp_cksum_mbuf(struct rte_mbuf *mbuf);

Probably need to add EXPERIMENTAL into docbook comment as well.
