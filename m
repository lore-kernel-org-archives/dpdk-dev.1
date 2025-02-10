Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D3C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58DA04067C;
	Mon, 10 Feb 2025 19:24:42 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 83F914069D
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:40 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f7f1e1194so46320945ad.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211880;
 x=1739816680; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByhVfSnolEU9PwaiDqAEqzEZpnpe7h3L/53jsBIN/hQ=;
 b=XtFtLPX0IuOgCoq6SFny3o0fNlAFIB91Ag3nrj/N2hLgmlfd5QEJp25XVZ+FbW4swu
 s7A0gpknKkFPsqM3TFgV6mKdzyykHF4zlb5xWZGsOOnMG19WewKGmP/5lJ2KZFDx5O7Z
 6hfln+k/P4IdsHVhwhoJ2wGC5GWygkIFi9ytx2JQGtCX7ygqNhwon2xxGiGgpl7rx9YU
 Hd/tgD5AdjqSVyzZliaE0lyrP+peTlxx+83NIBrURi1AWdYNJGG5+Dft5IbSmFhMxHnG
 JzMJ5Se8vCKH6OkES9sZo9JXEBDUh9Wjf4lUc0rMslTs3wZyI8V8uQdYswOPnq/dL7lv
 79zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211880; x=1739816680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ByhVfSnolEU9PwaiDqAEqzEZpnpe7h3L/53jsBIN/hQ=;
 b=AT/OSLTJTvJKh7inSeOI/E6NYk7Xej+9lcL3fzhJe+F9yyz4zFFmGo41vTD8/G+0Be
 ke19pOXuYmYr7gwWofsflkA5JnUn6ctfd45LC3KkrwC/hMp8xFdlS3CtKeidIfkRKTov
 j6fOd87fnF6SjMJNm/c5CQ9/SUjgSU8QqOjvobaZJURXJummg8Z9tDmspxy1SXvpodcK
 No3qrjRHVCh71EcRSB4nNoy/8AuMIKtObKvvyggp+maEUPUzZ4+RjAcO99xCWYmS8lAW
 1+CrteS5vdmnich2ySNG0TmNzhVUVxj0ttwQ3KG/8TC7xYUkI5z5xt4jn0A2APxqXFYM
 f9Fw==
X-Gm-Message-State: AOJu0YybHKjffLa3MGMDkfENBkPtW2aw8DorpbV97V5luPJcD3BjI8c9
 utC2SJH6+pNksVYD2WMW4WHgb5zAsd/DrII5S2iXYcAtTXq49aQ77YqXsLKzma8=
X-Gm-Gg: ASbGnctSwPEZXQpOUujEldwBN3Z3MRqYRMSmtWC3qmkt7m+dbOZYsnX3aN5rq6d+7Q9
 efkEo2CdDqxfE3/Gcp6YysCnUHdLDuyM2qK2ZSM8yARI8QcLhF9aGKw8KpBggunuLJS+4mL3e5x
 ypdyAwVDzPzPrifM5p7KNueQRnkiMvJlidasWwRR3HUaQSQU+bJO7MgTZPdZQ2Lo6IDPl3GPdcU
 YM7ScD02fop5XGMmfLwLhX6/r+N6cv3voTiDgj+lPs/Bdrl1WDc/zm+AULHS6SuvR2lLvWarBGQ
 lziwxng7QmH52OK4xISQ3kduOaPD6dWfOZ2O+V7oaPdMNMP3B9iLextGXifHkhgVqj3d
X-Google-Smtp-Source: AGHT+IFNmglFv8+5oVbTjd88i6vyU690ubUSYf5ljK8OIwvngfhY+kubsgWm6z1qrXLpAMUNh1DmQA==
X-Received: by 2002:a17:90b:1d52:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2fa243f0346mr19780467a91.26.1739211879784; 
 Mon, 10 Feb 2025 10:24:39 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:39 -0800 (PST)
Date: Mon, 10 Feb 2025 09:28:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 03/14] net/zxdh: add agent channel
Message-ID: <20250210092827.223f8bc7@hermes.local>
In-Reply-To: <20250210014702.4105460-1-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210014702.4105460-1-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:47:02 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static uint32_t
> +zxdh_np_comm_mutex_create(ZXDH_MUTEX_T *p_mutex)
> +{
> +	int32_t rc = 0;
> +
> +	rc = pthread_mutex_init(&p_mutex->mutex, NULL);
> +	if (rc != 0) {
> +		PMD_DRV_LOG(ERR, "ErrCode[ 0x%x ]: Create mutex failed",
> +			ZXDH_MUTEX_LOCK_INIT_FAIL);
> +		return ZXDH_MUTEX_LOCK_INIT_FAIL;
> +	}


We went through this recently with other drivers on the mailing list.
You are adding dead code.

On pthread man page:


RETURN VALUE
       pthread_mutex_init  always  returns  0.  The other mutex functions return 0 on success and a
       non-zero error code on error.
