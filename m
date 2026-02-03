Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E7E87834
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 14:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EB36402D9;
	Tue,  3 Feb 2026 15:35:54 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id B8F954013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 15:35:53 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43591b55727so5037654f8f.3
 for <dev@dpdk.org>; Tue, 03 Feb 2026 06:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770129353;
 x=1770734153; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDpISFuEevHZy5MyU03Vtt2gj40mQALFAnsvXF1pnYQ=;
 b=TUZ9jnQCBbLgaC9cgK5jVcIh3DW3lCxwWt+yZl5b2xTBhGK1kn9BbI5ccups93EBe/
 +fk0cRmNqcaXtxvqlpTHfi5V6qeOO0KrCSbHbsFwsyv7Q4iWFQr5DmEcVaEgvaJgOptC
 QB+J6wWIGuezuL0ouJWMgjlA05wR9DdT+M6D6VYoIbYvpNt8FNLUcTd8n64gLW77Bilh
 BybYY8joDmarSZfvFAutJEjtZ08Bm4qwPn4AQHlUXylDc+/iRrIVyYT+uUGql2M7m1pB
 nyi1yMTnu2ySywsDdbYPpQh+Vh+V89ooPhaWCtyL9EUBPt8ZLjI1AZ2x0z46FIaNlyIq
 7H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770129353; x=1770734153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kDpISFuEevHZy5MyU03Vtt2gj40mQALFAnsvXF1pnYQ=;
 b=Lq6N5eI+Ds8430ZS6ueancYwv06gKKKb9pHL3EAaI3XanZdsIE2TLaoHTNIJAi6VX6
 qChEcr7PobV+C8VhUNjD5nubRTdfg4Ey3VbAdV645HEU/n75p3B9gsoc34NEsD+39pRB
 UruJH33JD27PuV0xeYlNN79F+xL7Oo75EYtYS+6YorVZkvEQvBvfm1UV33G6QoEC9hLI
 W5S7sQtpuc81QSSXkmEjc95lo5j+RIPZYOdFxyGOqlOmq/MUj1d3dfDS5c1jON1XDP+J
 b3TGvtLiTc+neoKRy2V7SxGIV0EsiYEQo0ZdeHn4AjX/YwY/shI+8B84hBb5B/lnybW2
 zwGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCcbOeGXagFOXefPMhGx77Q2Yoa9aKkvF6WU9BmoaJ+Apc+QYsn8oUgpCgt/8rQ6W62d4=@dpdk.org
X-Gm-Message-State: AOJu0YxOyaqH8XczxiYCxk5wLCbRaNEizLze1Dxe8qHVVw3X2p2nbSIJ
 T7AK8fnR9a+789wtC35OFfZev2ROjM2rzmBJzlBLR5UzJmrLpPZkJwIMwSfdoPz14hM=
X-Gm-Gg: AZuq6aJsEkXYysiL0oxAv/ZlTxdksBUxWIsXc4ID8ywA5Gx2dRZjKvxtZ3Jk70xglU+
 o0W2BdYLg0Wh9o80P/9+4sweZh2v1sNJD5Hk1E/P5H0kC4/emePHhYLkicDZgUVM1mGiF+Rx4zH
 uyRhYCT1K1c2SqfdwjPjmKTE56Ch+ihn95UN6lRdfw1rLf2X/6CxXhRnKBG4EJ9/n18EoJB5sxC
 l5+YlinGLBJelC9diSyh/8GxsF/fbUi9APtgLpQnN8d64YlNy88X59bwAHUJ9xY0HI1I/lI0ABR
 I1Aprq5PXmmDjNwp4v3JPpNCeMAu+x7krpl1liWrZdqhPcbd8FN5+BeUobvy/7MY6AQ9KSX6+Ru
 Kit+8KoR5wciDoDBjFo1kEIONtp3U7DwhBNP1z1B6OygZdm0oFkaYHTvuunN9MbyWjNBzUnrp2c
 UN/wFCTuhnnznWau5Pu9sJqVZLa967P0WuWkWMA9d9k6D3iUzk4qco
X-Received: by 2002:a05:6000:2408:b0:435:907f:e436 with SMTP id
 ffacd0b85a97d-435f3ab0248mr24204863f8f.52.1770129353297; 
 Tue, 03 Feb 2026 06:35:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cefdsm53544240f8f.23.2026.02.03.06.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:35:52 -0800 (PST)
Date: Tue, 3 Feb 2026 06:35:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v3 2/2] net/zxdh: optimize the procedure for NP online
 uninit
Message-ID: <20260203063548.3336de5c@phoenix.local>
In-Reply-To: <20260203071732.2601630-3-zhang.tianhao2@zte.com.cn>
References: <20251230081127.813605-2-zhang.tianhao2@zte.com.cn>
 <20260203071732.2601630-1-zhang.tianhao2@zte.com.cn>
 <20260203071732.2601630-3-zhang.tianhao2@zte.com.cn>
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

On Tue,  3 Feb 2026 15:17:29 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> Remove the NP software resource uninstallation procedure from the NP
> online uninit process. The NP software resource uninstallation should be
> called separately within NP uninit to avoid duplicate resource
> release.
> 
> Signed-off-by: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
> ---

Ok, but slightly confusing commit message; can I reword as.

Move the call to zxdh_np_soft_res_uninstall() out of
zxdh_np_online_uninit() so that software resources are
released once during zxdh_np_uninit() rather than being
freed twice when both paths run.
