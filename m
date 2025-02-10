Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E074FC0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1796840A82;
	Mon, 10 Feb 2025 19:24:57 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 1861C40A84
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:55 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso7477957a91.0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211894;
 x=1739816694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvHnx4YBWuc968J9OJIRvLVKpHOMsliYJqxGGvyS5Ts=;
 b=SGNP2+0YlqfPU4jHmxov6S3dpKYph04ohsXzqQo3WqQRhDY9UvJil/SqpBpR/BbtQV
 4YdDhYSwmbtfx5i1RHmBecHKydztQzhailToDmDzu/FKnooVclFf8DXrDgU3Tti6zxtO
 0fGVjnvJIoS2NTkts1Nyr1hqP+wVAMycJl3KL5Xljyh0GHq88mXoxGTrZv/+BU2L486E
 FJLgr++hb2TSHqSP5jJNqwuX7If5sirUSC1X8lWtUBuqVWNnUP51y4/YaZ/LYqHei+JH
 5rXI3WIKj8KIzHkOs3hSS+AfTjFnkiQthd+QfxXXSvYsr53Foc6xUCuC9Anxgl30RLtb
 pQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211894; x=1739816694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvHnx4YBWuc968J9OJIRvLVKpHOMsliYJqxGGvyS5Ts=;
 b=p9tjdLa3VQ8+EvB1FciiZcm4Z5JDiIy/VRT1osAlwqp5yB0NmXK4p72I7M9riKEu6n
 WmzOfMxSaV0WYE0DXK90l1oG0/qKngHFWzq+2wTtLSN+dZidFq6ZhQw5TiOqmV6DiPFX
 Jtco9zXe/OAvUngo2v2RhlciyufzF4R1BRBolUsVMrf7LruSQ5AVDDcR1kQMjeFJSHC0
 PC1jga1KzyItiwILjSOwTW+EvlTLbO4xzxhhmGUibI/qfSHURrz+M3WKmEtpCTVMIy1Y
 w/ViecfBEs7H4D2Y4d1OlxuedyZL4/o+TaYhg5Jovr1q27W3s6Ocg49LiYNSgscAJILD
 +BgA==
X-Gm-Message-State: AOJu0YxmGFATya9bo56YnI6VKuZoWOmEETuVtrJiGxA60EdWsxM4b3fV
 M/MDSFbMx0DaZJgZiXS9COqXKLbwjntD2C4IgphttUYYe1M2sOv6erVRNGpESE0GA4sb2lVe2PI
 8
X-Gm-Gg: ASbGncs6sppG/gvFKjG7bFE5WrSJMv1mnt9P0tYM7jGojwinkaMuvhJPSEdPjv7PmQL
 GChfvO6iB3L70C99Bb9OdbiSupKt6EtCxzif208aZZGHYCLs5UoDTQ3usA6JLDQDjjxl25NO/xB
 u0smpJEkcf4/qhPgDnhA7FlO1EI+83F4yLdDz6hiKonHb//A/bVD6LcOvTokOhQj8JDccms6yd3
 f7YrmphVNRxPxvXo7aRoH1a2lc7Oor75Mhy0MvBZo24OFAWT4ey2MrChi/5K9xIcTBUM5tajeVS
 mXFPqtVvKD+VWb7zzUkdtnCTojvoRC1Rkf3T8xpD/GGoszAUMEKpOkzFlxGpI1REEj7P
X-Google-Smtp-Source: AGHT+IGR7cS+xB3cQgkyRYMSALdz0ffbCUWs8pIl/33ZaxcID+84Tfe6OitrXN3ohXmMvOSnApKhEA==
X-Received: by 2002:a17:90b:3b8b:b0:2f5:63a:44f8 with SMTP id
 98e67ed59e1d1-2faa08f523emr570696a91.8.1739211894211; 
 Mon, 10 Feb 2025 10:24:54 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:53 -0800 (PST)
Date: Mon, 10 Feb 2025 09:50:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 14/14] net/zxdh: clean stat values
Message-ID: <20250210095047.0a33ede6@hermes.local>
In-Reply-To: <20250210015017.4105624-9-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-9-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:17 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +	p_temp_data = temp_data;
> +	for (i = 0; i < 4; i++) {
> +		rc = zxdh_np_reg_read(dev_id,
> +							ZXDH_SMMU0_SMMU0_CPU_IND_RDAT0R + i,
> +							0,
> +							0,
> +							p_temp_data + 3 - i);
> +		ZXDH_COMM_CHECK_DEV_RC_UNLOCK(dev_id, rc, "zxdh_np_reg_read", p_ind_mutex);
> +	}

Looks like lots of extra indentation here
(could be mailer just getting confused).
