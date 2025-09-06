Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E40ACA1002
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Sep 2025 04:51:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96721402AF;
	Sat,  6 Sep 2025 06:51:09 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 1610F40156
 for <dev@dpdk.org>; Sat,  6 Sep 2025 06:51:07 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3dea538b826so2224845f8f.2
 for <dev@dpdk.org>; Fri, 05 Sep 2025 21:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757134267;
 x=1757739067; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jla8FZjsfLzOmf6IRLJNmspeGjrWKz+qujNkjiq+iiw=;
 b=x+0IouoTYouwQw+s6Rzgbyyz+owwqYZdL75Zwx0MzZaAShrULLmwidahSeNYAZOISL
 G+KZll//W3qrOo+Bnnxl7gQuvdxkz+I4zsxuSKR925qaywjnG4RcTIGMHsd5CLSQ1coZ
 BnLFRZKw3aOTaoV4/ZAogogegzng4EgR0k0Gp4fVlHpVYsrsSitiyb6R2E5aHZoHdTFh
 IzRNfb9gDcj/mwegrvJ1szitehMRuh6jIWWopBmKb78ZBt2rStlBzoNogA2IQx56/A0D
 t6wthdtTvRqS21OsRpO8QJm5u292PZemiF4z79j6xHAkhiuPc/clrwmCzO8qTVNZvpcN
 ul9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757134267; x=1757739067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jla8FZjsfLzOmf6IRLJNmspeGjrWKz+qujNkjiq+iiw=;
 b=lTczY5/FgTIjgf+O5dhCsfiA54Dch2+XF1dwx4bDh5tHqlOik/R+B2EbeI8qBbDzxo
 2vYtoMkhVYDRezwBZFgKDZWRpHFS/JuwIgLw6iCJrWhDFdVRFQAtl+nNFAKQqfi3Imn+
 LIVaYWFdYIlZTftI19WmlAGKea8HFnAdNaiQZO1a2yuqnzxbS8RIzkRcrR/IRpSyMbLM
 yK80gNi0yYo1EYnq4+UhkFZBxXqdgi3paGLQfEYqr/Is4NHgaL3ZtB1mrthF+e9t1nap
 D9O9rs1vnrntTfZBCzgGsgt+rVBLuEbv3QzbLlwF0Q16Xyn1z37rkXgvgY4Va1liwXLQ
 IKPA==
X-Gm-Message-State: AOJu0YzfqaUioOACZ63MkUKUU1AEAiDZzUYanmCoOYaT1Hc45kUN5ppD
 sEfnxDKqrDRw8S8hhjRO/Qd6bBm7Qq26rCckip/e+aMotZTfgkiMR+0Y/tG1yb2YlWA=
X-Gm-Gg: ASbGncsg5aoxg1qxgzhgSnXIHOcHGXVAdZtezBrOj7qZl+omJxlOe/dalaLNh60YF8u
 6QwPz/qw6xDQ6bDp1srmZRy6YtkN37eGlVcedFePLQyDNSCnK3+4MgLWCy58BG9PJq4y5lo94/O
 Ytx5uAc+XIoSrPpbvoElimvoqGKnuDlnLb7Ub9OVN4/f5MA23W/GJ9fbK8VbW+nyW58mkQN/MK+
 SN4Q7E9iFRTTK8aMeAD2rmEvxi3BHZ83q39vUyeL6WNPCH2FGXnX1be+8vKoyL0Kuc/K4e30mk1
 eb8qASL2qkB4UNMdKb4Ug7Izv0dQtKNJCr6S5vfm0LEbbBD5qYdfMQPO/94UsJqPa50glQ2opwF
 ibpUk304Q6EiFE0yzCJWDsgDotzPdrgvsbbBJMFdU4DB4V3WfQ7Op+6arPg4+J0pW9aYV3PhThn
 4=
X-Google-Smtp-Source: AGHT+IFYc+721q3NvoufofNgb65xOm+3YGQu4OTZU8uYowaJNgyxc7vn56a8extnOlfQQE+7T8aseg==
X-Received: by 2002:a05:600c:3b23:b0:45d:d3f4:a640 with SMTP id
 5b1f17b1804b1-45ddde82751mr7820315e9.15.1757134267455; 
 Fri, 05 Sep 2025 21:51:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd0350e80sm101923825e9.22.2025.09.05.21.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 21:51:07 -0700 (PDT)
Date: Fri, 5 Sep 2025 21:51:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ed Czeck <ed.czeck@atomicrules.com>
Cc: dev@dpdk.org, Shepard Siegel <shepard.siegel@atomicrules.com>, John
 Miller <john.miller@atomicrules.com>
Subject: Re: [PATCH 4/4] net/ark: improve Rx queue recovery after mbuf
 exhaustion
Message-ID: <20250905215100.27c9574e@hermes.local>
In-Reply-To: <20250903212846.268492-4-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
 <20250903212846.268492-4-ed.czeck@atomicrules.com>
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

On Wed,  3 Sep 2025 17:28:45 -0400
Ed Czeck <ed.czeck@atomicrules.com> wrote:

> +		if (queue->starvation == 0) {
> +			ARK_PMD_LOG(NOTICE,
> +				       "Could not allocate %u mbufs from pool"
> +				       " for RX queue %u;"
> +				       " %u free buffers remaining in queue\n",
> +				       ARK_RX_MPU_CHUNK, queue->queue_index,
> +				       queue->seed_index - queue->cons_index);

Keep messages to one source line and succinct as possible.
Assume messages in production are going to a log manager such as journald.
