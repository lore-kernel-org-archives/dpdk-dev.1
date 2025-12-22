Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594FAE67810
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 18:38:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89CC1402AF;
	Mon, 22 Dec 2025 19:38:50 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 7405640264
 for <dev@dpdk.org>; Mon, 22 Dec 2025 19:38:49 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so2816467f8f.2
 for <dev@dpdk.org>; Mon, 22 Dec 2025 10:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766428729;
 x=1767033529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fR2p2xljmSDsbjCgxBLVo24r/fq7jdwOYbCqEKet8h4=;
 b=wYWuwAueauCQ+ArTp5Yp27jcFFKJVhpNL95IvHh/XO+eFVlG5r+2V7pN1KlBOQ9Uzi
 WV6BXg/t04uMKZDxAX9HrCQYv0paUuqwTzyg4B+JxD3HmpEtjsmPt8aVgFWqEtNivTJx
 LMBWoWsVkZSkKG15/MbmySdBp3S1X7QAx5w/RshMq3zSPRbaZF1np1Uvp7cpzVooLPYV
 hn0Dm+RRzr66Q+TN95GmuK7iI49WJlx1YBt8XIqjvXL1VqwEFsU6aGMFGnl1E1vUvWLT
 bhoFXpyktMRZMyAV3v26AkX3ujPR/l6UNC367yoSfY2wNlWe2EWzfej0F30DyyCThn8y
 H0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766428729; x=1767033529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fR2p2xljmSDsbjCgxBLVo24r/fq7jdwOYbCqEKet8h4=;
 b=l6D1peCQa2Mu0FLCgoG2XXkI5nXSU77gUYZDz3juZMRmOdlJ5DuSYjPSJAzqUGMN2a
 auo7i3ODEpUdYqmgtmmvlWqlbX0/rk3A4KXx9142QIzveZ3wlI18sMuH4EAep31LV5WQ
 /MugIymWYvvtc/mBkdYIA/fo/cItUsPVRfJfh+YVaPrNppmkAQpzgFSQu+Ihip4tFLP3
 O1VTYULUMGVTOKnScTKUHcMWTTOXkkOw1UgqUT2mXDKCWIM34BQhfRVoHEuEP9JdrO4q
 19KnOkTqzKWRd7QopsDi6Ba61vJfyuyXaQGuA5KFVrBJKlV/W/2rJFJW7N0kw2V08Ex2
 4nGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4jTQWUFCUjJlCqIuht0UX3deQgkXxGNZDcqdzRf12d+AHnzuPgi2jTUCoeb/6UkZEThg=@dpdk.org
X-Gm-Message-State: AOJu0Yx3XuE7JpCY9LQ7LJvoMHrDyAXTN18LP6Tm1DBuwHuiivwx/E4E
 aYsATCI5xpos4mCSWHDOtW6A2Xh9M641zNOm1EYTUJ3U1HbNTBXjOm3ilpIgEOQZnE8=
X-Gm-Gg: AY/fxX5nu+aZS6Z5J3EJP1h2Wedm7/Y9y1gmsjg7GwqQ5gUQcZAf2IkuVNqo1ZhiR8H
 DKWrkRIQ/2N/zQxuiTAJNqTZjAfJBBQ3saJvQxTVvmIVG/1qbr1TMZN0TLnz2jWDDbPwtCVLdR+
 vllmBB4kYR1r7YALnNJAaKHU5zwEA1AioonBXh4AfrMIuWhm7QWtUKlj++obOSYSjtpxCUWMrLL
 di0/A1Pimt30bdujdg010Dt2/cmv0retzPyWjhggLYnS+WA1m/gdpoC0/XyNeZz4h6CuthabJoB
 k9IcZc6WKHq3eQQr5bj2TbbMF1PtiwsHSu5Q86t9TD9hupsPn+w86dyg3+rj3/VE3xyfGHBVRiN
 S0bn0wWZ/cLvG3br3v5MfWBwEj1PMJVmS7p4j1/k0Errt0Kkt4ZInWsEbzf4D8dxj2ywCf4QbxY
 2IVd2GCVHDUBnryAhaQAHQohfc764gxUTDNBd/NvtMeFYgMODWaTlZ
X-Google-Smtp-Source: AGHT+IFDLZfj0vB51X/6/MbO4mNBloLfMoXMpO95b9ljygpRzd+tUAcTWJvMEF54P/Gp+3egWABc8A==
X-Received: by 2002:a05:6000:2c08:b0:431:35a:4a8f with SMTP id
 ffacd0b85a97d-4324e50ab9emr14010423f8f.47.1766428729029; 
 Mon, 22 Dec 2025 10:38:49 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea22674sm24342926f8f.10.2025.12.22.10.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 10:38:48 -0800 (PST)
Date: Mon, 22 Dec 2025 10:38:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1 2/2] net/zxdh: delete np soft resource uninstallation
Message-ID: <20251222103843.6ca407e8@phoenix.local>
In-Reply-To: <20251222102535.401064-3-zhang.tianhao2@zte.com.cn>
References: <20251209021609.3911854-1-zhang.tianhao2@zte.com.cn>
 <20251222102535.401064-1-zhang.tianhao2@zte.com.cn>
 <20251222102535.401064-3-zhang.tianhao2@zte.com.cn>
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

On Mon, 22 Dec 2025 18:25:35 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> Delete np soft resource uninstallation from NP online uninit process.
> 
> Signed-off-by: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
> ---
>  drivers/net/zxdh/zxdh_np.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
> index 4e2637e1b6..3bb765e05d 100644
> --- a/drivers/net/zxdh/zxdh_np.c
> +++ b/drivers/net/zxdh/zxdh_np.c
> @@ -4243,10 +4243,6 @@ zxdh_np_online_uninit(uint32_t dev_id,
>  	if (rc != 0)
>  		PMD_DRV_LOG(ERR, "dtb release port name %s queue id %u", port_name, queue_id);
>  
> -	rc = zxdh_np_soft_res_uninstall(dev_id);
> -	if (rc != 0)
> -		PMD_DRV_LOG(ERR, "zxdh_np_soft_res_uninstall failed");
> -
>  	return 0;
>  }
>  

OK, but would like a better explanation. I assume it something like "soft reset is not necessary on device cleanup"
