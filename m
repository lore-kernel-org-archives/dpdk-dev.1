Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720F0E6FE24
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 17:54:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B45E40265;
	Tue, 23 Dec 2025 18:54:27 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id 84F334025A
 for <dev@dpdk.org>; Tue, 23 Dec 2025 18:54:26 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so906687366b.0
 for <dev@dpdk.org>; Tue, 23 Dec 2025 09:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766512466;
 x=1767117266; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYD8uPHF5rkleyDgC8Ht1vSbml5wvfysMNoslsPPDJY=;
 b=npfiV07Cjd6KfZPsY7iVS8PLWApnaBLkzs8XvDLTYtQRcAhDecOoP8tj/BMuihd3L0
 O+3LQt0W3Gz4YjcogKTnKFLuyY+VdSeSre3mOpdLfxwYxcOF0KqGIIeEbohkHbCRxOPM
 qqZxJO02ocREc6RWtLOY8sLnTEgjEFqbYdXRxRe1P3xwKPqcckq9BZDtdq6oMsIMgfIw
 v9n4D1HpdVWoKhyDR2wFvLrY7G/oeUjS0CC8VTppGXM45sR4+NGvq0Y7vStRPT8e7C/M
 6Ymrx790hK5IjiUKuUOLB6uMjIebzFCSDiJKk3io73fP+ndVbf/sO1/TrsbJGw17bNPG
 eUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766512466; x=1767117266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rYD8uPHF5rkleyDgC8Ht1vSbml5wvfysMNoslsPPDJY=;
 b=LWkBM6sqs7vAob778GD5pv0F/lEgF5eNllF+RZxsB+iclnpJriTkMmOJILD9fflYv8
 mI3GxS3Uw9DM/IhHxxGre+3jGwOCy0uA8ZRzavLNKTvKzJyBsAqfu0XR98VF6KgyHbu5
 K6TSllhFFplOsi4WEX1Q450l2LIwxWKYoLSYwA6MFjIV7MKPEqG5fOWvhxqFYDKazj1m
 3HMyPFQQ3zxpajVN+hZQx9orvWD13qTw8cbZgb1BxlCMmSPKBc/K5G2u/H2GLF2XXetu
 pBM/PFbjFjf8QRomkWS+IcUWP35vhEpLvalv+DJJ5gis6rJSzif0E0vIkVaUd1M9z23D
 tLyA==
X-Gm-Message-State: AOJu0YwomWT1R3Mo7VKRwJ2BS6buZ7f7EZSXcuKR8ZGfBy50ymjsqN5T
 BMKfoSdI29IZIwXn0TFVcM/AUR3crh5N26wSPQKXNeZK/++lA0E6PAHtqln6Mg8htLw=
X-Gm-Gg: AY/fxX4HfUdLS/QmcbbQYIo6NHTh4EkznE/8E9tEXBMrdeezjbV+APUoOy39Lc/NIie
 WMoOpm2nVqi1q/lPB8N1XvaHMDGN8nphXGA/2JmTafDgYx2AuK/uT9t8MNMHz88Kxs14PVtVxzB
 bDHJJxrlPZb6uiHqdYxL8y4/hHwT7aEQNXlz2/QWBab3lmGO8E0yEMhVmPrn7uRJpHt/1e/M0JA
 HYqPC1M5CJRTtT4dPP6rAzItCKpwf2AOObzxgW5imWczowKaL7y6zLN66Ut+hFn7BejUiff3Ku8
 dx2YTBZRr4gHTo65RLUXKlwFHRkbPBD8Jj1vDzcgKy/X1cJp11HclL7XSs9/mJcARUaXmX+kmUy
 oDobPbp/aYbDdJCMgB2aXQEzxL+iYT90y0FEQCPVR+4NxyiPDr+KNer18qISiQBp1UKrO/jIiuq
 aw8t/mABDLraqFNaAgT3dRfD8XaQ7//lKssL2NgoWeAJ78lv5OEc8x
X-Google-Smtp-Source: AGHT+IGy2idr7AbRVxzcwYT2bW/m8FTXf2zONCnAdYBVn9kKn9YzSNsYqzgsG1S3bqdAmmfgKx1XuA==
X-Received: by 2002:a17:906:4fd0:b0:b76:23b0:7d89 with SMTP id
 a640c23a62f3a-b8036f1d8d3mr1636460966b.14.1766512465101; 
 Tue, 23 Dec 2025 09:54:25 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de1421sm1496448266b.41.2025.12.23.09.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 09:54:24 -0800 (PST)
Date: Tue, 23 Dec 2025 09:54:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 4/5] net/zxdh: add support primary/secondary process
Message-ID: <20251223095419.0a753877@phoenix.local>
In-Reply-To: <20251220061521.289722-5-wang.junlong1@zte.com.cn>
References: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
 <20251220061521.289722-5-wang.junlong1@zte.com.cn>
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

On Sat, 20 Dec 2025 14:15:20 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> add support primary/secondary process,
> and secondary process ops only support get stats/infos.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---

Please update release note and the documentation.
