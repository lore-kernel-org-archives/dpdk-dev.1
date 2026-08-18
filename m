Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E03AC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 02:16:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56D3040A8B;
	Tue, 18 Aug 2026 04:15:51 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id B56544028E
 for <dev@dpdk.org>; Tue, 18 Aug 2026 04:15:49 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso2549416a12.2
 for <dev@dpdk.org>; Mon, 17 Aug 2026 19:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787019348;
 x=1787624148; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X/0/QNVCFHw6S2XToBmWdkUjgoCrfaEPtF3e2aJhonw=;
 b=j05edn+7vIHs1QxX8WS8+0zCV2hJ1hhdtzv2zIJAMAcT+0yT/V2pdApOUDrlyu8pDg
 sYOg3Era6tXLR54M6ziZuw4uj+7/nFL9B6m1Ylyq2+AdOwZRCdesof88DArXpl8bZ/NR
 ojcoGTkSp/y7pSeU43MbGnoeSN/XvhVm6GooFucQePsO/05sIvGVh8e0BQRLrwBG/A3c
 PTQDC6xNyTXtJ2L93bvfWIfsbnsj/Ts2UajW6/WkfhuKqi4471YNzGw5zDE3OGf7UFyP
 Ue9agKh4AlX15E5ea75A+0MtBUzJlDdXZa5VhDSA/pr9wz39M3QKSKlwhnfdaADuQExV
 453g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019348; x=1787624148;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X/0/QNVCFHw6S2XToBmWdkUjgoCrfaEPtF3e2aJhonw=;
 b=AeaZTsLgH5PAjCLEvn7c+qZCG7kHnWcgR6W6W9DhcP+Pz4UB5S4Ya5atxudS+PMTIc
 Bar9oDoXjhiHZnKddkGmdN2RETcUCdqt4/fEenuzUXs2HE1LEz5OKNP+2+4ZOnuM6Nkq
 CaI7UdI+J/izjJF8r6gX8/ZEoEgdifRaQZX4BsLIhAM+YSuN1aZleecb21e1frsvT8hb
 z5AxYH4r/tL434JP97Hoq4nYVckAoz4ynnW6OuElNFyDUfawt7IYYSVuci3u1+72duS5
 eEDyZhf1nXBXqemSiOvuzbpp/+UTLjNLED8rczhBVbddT4ZYFZ/V+d58wbo6miNVz6zy
 3HvA==
X-Gm-Message-State: AOJu0Yys1Q19U4gWH2NWoZ4ao9fB/im1Cm5HZeY/GUMWv0CpMHWDXPCg
 z+coovA/S8A06kboqj1gTDTcnJXeGQx69cmaN2roYojmt4jQkIZLDsL33aObWlQPcW0=
X-Gm-Gg: AR+sD13cDmNYt2+i8esFWOWektzmaAUPgwWE2P/cTOeLKQ7F4MgO7sQQ6oBlUXz4Lea
 a7nr66p6d4GkrDAt1YSpt3aXgCBYV4RNaDUrUMDZJFe1Wph0Xt+2Ml8am/TF0ixuophVNW5yOS3
 wjLDoSSgFWCHy/C+4y53AHV+qW28KjyU8rqQFzTd0v5OfMoPAc3bUH6CS5OQhqAUVYlJ1agwWxe
 IP6aa29IS3UhZFH1EciLAAuK6kaQ2iXNGNVfLXCJ30oc6aH4QJUsMgSP7mDktYPq4dHzukEscgF
 LqhlvTXvpPUkCeteH80Tlh1/h6iUhbGJyBDUY5QRc4jpVl9s0xEgb10+rxGvWKUiBS6ALa6CH67
 WfeZmY1iWy0aKTpT+wjA4t2lVFR/ZfqMYOpxqdcJhJeYoVUt7PmR73feWdRrDUUuaHfVFTt3PQl
 /5KbRrA5KhkQVCPDeG3iGD6L7+RZRK51KmF173S2hA+xzGs9yb8niw6G5R8XTY9nDwhE7WLBtlX
 UZ1LiWULubovaQQxUI9cYapB/tkpA==
X-Received: by 2002:a17:90a:1547:b0:395:4de9:b30 with SMTP id
 98e67ed59e1d1-3954de91bb4mr6692223a91.5.1787019348588; 
 Mon, 17 Aug 2026 19:15:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm11941602eec.11.2026.08.17.19.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 19:15:48 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:15:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Randy Tice <rtice@cisco.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4] eal/linux: harden uevent recv error handling
Message-ID: <20260817191533.5e66840c@phoenix.local>
In-Reply-To: <20260817201602.120526-1-rtice@cisco.com>
References: <20260813201656.65649-1-rtice@cisco.com>
 <20260817201602.120526-1-rtice@cisco.com>
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

On Mon, 17 Aug 2026 16:16:02 -0400
Randy Tice <rtice@cisco.com> wrote:

> -	if (ret < 0 && errno == EAGAIN)
> +	if (ret < 0 &&
> +		(errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)) {
> +		/* non-blocking or interrupted */
>  		return;
> -	else if (ret <= 0) {
> +	} else if (ret < 0 && (errno == ENOBUFS)) {
> +		/* non-fatal transient memory condition */
> +		EAL_LOG(ERR, "unexpected error on uevent recv: %s",
> +			strerror(errno));
> +		return;
> +	} else if (ret <= 0) {
>  		/* connection is closed or broken, can not up again. */
>  		EAL_LOG(ERR, "uevent socket connection is broken.");
>  		rte_eal_alarm_set(1, dev_delayed_unregister, NULL);
> -- 
Since there are multiple error conditions it reads better with single (ret < 0) if followed
by looking at errno.

PS: if you are getting ENOBUFS, the root cause is not having big enough socket receive
buffer and/or starving out the core handling control operations.

If you looks a uevent the internal state of devices is corrupted. Probably need
to figure out how to schedule some form of rescanning.
