Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4C4E776EA
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 17:18:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E80F7402E8;
	Wed, 24 Dec 2025 18:18:15 +0100 (CET)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id BA00240262
 for <dev@dpdk.org>; Wed, 24 Dec 2025 18:18:14 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so7157859a12.2
 for <dev@dpdk.org>; Wed, 24 Dec 2025 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766596694;
 x=1767201494; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+mCtlWhTa7aiZpBInY/vQ8RHiqUFLmzg2YUDKBrsgw=;
 b=xIXV2k6DkajQ3oje7qAD2AFf3M8lJIQIWYpGQy8tKmQ/KXHfWHaEO2W+rk8FcWGVhk
 cVbdBgYhWKVAlkTV8P594WVpfpIo3cJZLEYOh7JABydDlFvmHDq02jrUkJlDtaBI2BCz
 npG7tMgV/jp2zM3mG//8WTaM4DQCgFReGXwjeQzko9vGKKkwfTxUPGAL1f2aF0T6IiFe
 EwlasncgWKb8ShD+J512TmdlWY9S3Ak/UwmMVto4KBkuL1ekyzWpMc4gHFBze7poPLGb
 Jc+d1alAr0wmczrbdmmR4yCAo591Z6lUWkznlqLWgBJhR7PnCMwsuNL4Qyq9D04hJIRa
 PRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766596694; x=1767201494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7+mCtlWhTa7aiZpBInY/vQ8RHiqUFLmzg2YUDKBrsgw=;
 b=TNrV2C4AA0+ego5LMm4xnugkQBWFEVaIyGUSfQpGSyiTc9SE4V7AEGn3cHVQ4TEPDd
 /d/rzb5n0O8FsxF/6+qZZ4vgwYUu4oRiApToKRkt56KpgdZFfnLNo5jX99PMEoDs9PM8
 08b6WyMj+eAC1f4Z9M3XCjUrVDsZ8AcJO3IlQ3vTb583s0oIJNjxfd1z2gGgVEpjYpNH
 g5MUN8NVEh10N8rQPiH3SquMQMIF3lwI4nzQuPGgAN8apQb81YiL5jPGCW82j3h4yrxD
 xuXlWFJ631OSUwuxhKNOoBWpDefh/rBEKNQeK16ju3D5U6DRpg9Mhpew64/NTOM+eUuK
 04CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwpQSfhkeFDI+qn8ysjK9fn0Nqdu8KaC8aduxV79OyeRDNgReIq7D/QsDMheKXhCXi5Rw=@dpdk.org
X-Gm-Message-State: AOJu0Yxa0eHEy9vCjLoBGLPg5XSl3yQ+NoP1YLyXSclRaFu+tOJ+NnSe
 2Rh1tAbJgQDTiaKnJ+yjB7cxb6e06BGgETAWEpYNGEd2x0SPgNFA3G2rwMHC0N8ncKY=
X-Gm-Gg: AY/fxX5Z2Wf+Z1IfnjzEk8B5fNGV+tTq89MNn+PwQSUK+gqo22IGqilfRxtu1f7/KPS
 PQpdVIumR6aGRelDbOZhydYDVFaP4oHyp03RioTqLGMNrMeYQQ2APEmsxWLsxw8+q5AG59BiF/I
 OK70HoW9Fivgej/TVnp3y9JTql+iwjrKLqktrV+92T03WCe8i35ApizBon4Vtp5VlahP6cMMd8K
 hssM3jb4Gc6+xMWtXezlMBBp4dq4no7F6SkqJnEMJGIdVhuVDIUu6K8vqGuUWj1zJqY37QlC531
 fUUcg5vv5B6R4QfyVtN92TSjnCoam0yoapQd3PYKRxz8eAmvGU2qQJa2uuDrktwVEz06yoXD/HF
 HnkWY1fP4/1im055PnzI0zpLiEU+hxrzM9xUVIgEmTyuv5ow/W/04viTV3eLosLxsroabYvSVcJ
 vQh3bn6z6AYMXcvcQhLP6mr6516IX2prQZR05VlrwGRCavQix8dVJC
X-Google-Smtp-Source: AGHT+IF9oI4tGMfVXMUkZi9IQPdqiMlp1xal8VMcy93EM+OeUZw03SfS6qVwlaZ6oXB0Mg+57xuytg==
X-Received: by 2002:a17:906:f598:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b8036f2fac6mr1574258266b.26.1766596693930; 
 Wed, 24 Dec 2025 09:18:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de11dasm1773794766b.35.2025.12.24.09.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 09:18:13 -0800 (PST)
Date: Wed, 24 Dec 2025 09:18:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
Cc: thomas@monjalon.net, ajit.khaparde@broadcom.com,
 bruce.richardson@intel.com, jerinj@marvell.com, rasland@nvidia.com,
 dev@dpdk.org, aman.deep.singh@intel.com
Subject: Re: [RFC PATCH v2] ethdev: update read time API in PMD to enable
 crosstimestamp
Message-ID: <20251224091807.2f57cd1a@phoenix.local>
In-Reply-To: <20251224073317.68784-1-soumyadeep.hore@intel.com>
References: <https://patches.dpdk.org/project/dpdk/patch/20251224064010.66586-1-soumyadeep.hore@intel.com/>
 <20251224073317.68784-1-soumyadeep.hore@intel.com>
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

On Wed, 24 Dec 2025 07:33:17 +0000
Soumyadeep Hore <soumyadeep.hore@intel.com> wrote:

> diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
> index 1255cd6f2c..000598b380 100644
> --- a/lib/ethdev/ethdev_driver.h
> +++ b/lib/ethdev/ethdev_driver.h
> @@ -798,7 +798,7 @@ typedef int (*eth_timesync_adjust_freq)(struct rte_eth_dev *dev, int64_t);
>  
>  /** @internal Function used to get time from the device clock. */
>  typedef int (*eth_timesync_read_time)(struct rte_eth_dev *dev,
> -				      struct timespec *timestamp);
> +				      struct timespec *timestamp, uint8_t is_cross_ts_en)

Could be bool? Maybe a better variable name?

You should also have an example of where this will be called with true value.
