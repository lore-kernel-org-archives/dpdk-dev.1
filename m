Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6112ECCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:46:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68FDA40651;
	Tue,  4 Nov 2025 15:46:09 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 22E4F40613
 for <dev@dpdk.org>; Tue,  4 Nov 2025 15:46:08 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-295548467c7so31539955ad.2
 for <dev@dpdk.org>; Tue, 04 Nov 2025 06:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762267567;
 x=1762872367; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9zTA3cyV9e0YncTtK6gxO9AhBUsHJ/8+s674lHq6CE=;
 b=IR0AXZHqIiG1CgsaOYbpNpZB3/2MmD7PYYYIjFmfLc+XuI7u0A0ZGuKLiwAHUhksZ4
 mhnYkO8NYlq0Pm2k6vAOQBpPh14MROe7m5MnV3UiOxkFfevFe7sqhg7boLa5R2lAIHx2
 xIdMcAbJeVJl34VY96QIQ2cIjqofq3Hg5oz38VCXaYtimjbU/UFNvZALrDvMHKaCa9ye
 DSEsZPxSF4d+FNj7mu5+PMSup+VQX2lNSYVDozTOBz3p3zmwyrOvDc6jQHPhb7LOsxgt
 05Yeeg6JbUU7GdTSjPfndx2myWe6mdDwErVSWsY6yiQZGoI85bbUYuTYg5hy6OYzPDx/
 cLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762267567; x=1762872367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9zTA3cyV9e0YncTtK6gxO9AhBUsHJ/8+s674lHq6CE=;
 b=Bup1nhMksFt5XJ57WubHPUo/DLNsFJz+WjCeWcvsTa5oS0j451LUwxcCK35gfKUHYS
 +m3q6zBC4rqwgimSdKzZXdj1ZNe4nLswPIkl2asO9ZxfKPxGuyMpKr7ZkjVsBEXALa09
 HcY7PebC/r5WPpFmtj8PLBkkLh2xjQFppOM+YSMr33j1nLC8cGCVpTgOSlLD/4nFvNDW
 Lb28UyNAqAbG/3yNKxGb+dmZ8BPuCKeic85IKysV9+T3Ti92ZpU/7F02TUZelW2nPZvd
 2o1YQEyPQKgFKOXfv1x5FTZ95tF0Ki1UfMiiqEf9Uu5AhDx2h8UyURhyYHmKqQGgKaJq
 CPkg==
X-Gm-Message-State: AOJu0YyziMK2mOCMkgT3RrUkSd5qbQ9KVcZfIGGKcKOUNaMBObZeZhZ+
 HvFqXylP4pra9auNwnvOPoLRE94FwHJfM0xsL2kCJzNezHcLSR9hSIwYYKrtG4JvxyAFPMbbxgm
 LLiht
X-Gm-Gg: ASbGncvwEkOu3gX1D9+LKDiLK9ZTMPXEY7R0X51Mpbe86a/LJn2mflgFVSdwYEDhPeQ
 sBhBkpll2f04Qad4Dzlpkrf/IATZS0zg6F7aRUMOVI0Wm/2GRkuiAvWgFI4Fdz70Aq6HEWlEIxM
 QVjfAxy54hC0DPTav+RngKzz2GxN2obaszttiHmvLH//h2BYzqsSD2FdfNekmZRhvKDYk5lr/Mz
 f4vJm2SADdrQdB9kte6x7a68WOAgWc1YOWbfyAhrLO11f/EhqM4T2f8biXh6HmYnbQq/9DgTINX
 gxkrwLH+jMtdhTfGzp5G9u8WhX4mT5xXFrEs7rmJaGlJFO5q6EcsELjL5V09CIfSNpF4AxPFXIh
 wVQozmCXJEh7jU4xcSPLny8bnixtjqqifmuR0EiO+uc7N/2196w2B9kh1GO4XhJJT97JwAHnSqZ
 ze6J0fe1OyLUYhdXQouqoAJuyj1kSd98+ywA==
X-Google-Smtp-Source: AGHT+IF+84rl6/cfBSfgwpXi0JKGtqiWcC17f7l7iQdCq6iXcOF4yn/tah/X7CuZ/Ki+ovGjjFEqeg==
X-Received: by 2002:a17:902:ea0e:b0:269:a23e:9fd7 with SMTP id
 d9443c01a7336-2951a3c0348mr216335585ad.26.1762267567191; 
 Tue, 04 Nov 2025 06:46:07 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ade3c864c0sm260074b3a.35.2025.11.04.06.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 06:46:07 -0800 (PST)
Date: Tue, 4 Nov 2025 06:46:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: jin.liu@corigine.com, stable@dpdk.org, Chaoyong He
 <chaoyong.he@corigine.com>, Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund@corigine.com>, Peng Zhang <peng.zhang@corigine.com>
Subject: Re: [PATCH v3 01/44] net/nfp: fix use after free
Message-ID: <20251104064604.0f334312@phoenix>
In-Reply-To: <20251103164915.101713-2-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
 <20251103164915.101713-2-stephen@networkplumber.org>
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

On Mon,  3 Nov 2025 08:47:06 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The code to cleanup metering was using the objects after calling
> rte_free(). Fix by using LISTFOREACH_SAFE
> 
> Fixes: 2caf84a71cfd ("net/nfp: add meter options")
> Cc: jin.liu@corigine.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Queued to next-net
