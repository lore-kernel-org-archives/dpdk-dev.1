Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA61093189
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 08:26:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FF0F402B2;
	Fri, 20 Mar 2026 09:26:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 81ABA40272
 for <dev@dpdk.org>; Fri, 20 Mar 2026 09:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773995200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCPL/7CBgDnylLqizcjpiJ1hRK2UHydBDNyiL6GfadI=;
 b=EZHDbNr/t+KjYcng6g6jMdlObvoQI+SM1Qendo/uItyBqRpZXD45JEOBZrTnE3T4aFdzZV
 AGHCPG6UWLmBjOO0+8J2+Ucf1fFohNTrlMDF5kaqyolWefcf+KpPpn5euCrJpitfbhB0FA
 ty1aTJelvzNCrzpQx9B3t1TTSX20UGw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-Ukxg4ocOPNWjr3caTwoxYw-1; Fri, 20 Mar 2026 04:26:38 -0400
X-MC-Unique: Ukxg4ocOPNWjr3caTwoxYw-1
X-Mimecast-MFC-AGG-ID: Ukxg4ocOPNWjr3caTwoxYw_1773995197
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-486fa9ea1ebso2286335e9.1
 for <dev@dpdk.org>; Fri, 20 Mar 2026 01:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773995197; x=1774599997;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zCPL/7CBgDnylLqizcjpiJ1hRK2UHydBDNyiL6GfadI=;
 b=YAcuzwEwFcTeWHD8/SiDbMwHfITCFoNiJo9cSS0RWd+3aas98/v9h9WEEcrmVBCxtT
 hhgQ7wlcolVPKiPOSOozn6+0HVl1lpauoy/ajyfo7YfxCjLWdWHT/QEV/OaZHjL15zQO
 B5iNfmOf0n5NBQqY4XByJmpYIdbfYC8pZQiZ3i5FIeGIhl6qeeXHu9qQS4FG9w0OT9bv
 KKmM8efBgLJaglhuTqHkw5GbSm0rAX+0hxWEDA3YYb5mY7sxa2C4CRQgAJypvV5Imr7B
 8K1Me4hHzSTkLjqHeZ/3OJiA6kRrbpgOtDNlyGw53lcsAcp3d+Q2jA5exKE2gXrZZ5iB
 U9qw==
X-Gm-Message-State: AOJu0YwVHE2TrrNmxUgvfbcu5YoEyYLuw9KiV4/vlfktUD9/6m3ZIXtg
 MDruSSPgnUw6JTSK8lFGzlT5Q6DWuZh99xQYRPkouUrXWCdlqxtSjy/QC60zzJqH082IjmWC5Nz
 lc63v/Dd2fsdj4HodppzXDqdr5M0FNgQIPe1i6Q/jFN1ybDc+EzZw
X-Gm-Gg: ATEYQzyOZRXPcqd7WlTZoiU5zxrtCnd0+r0Zl2xJ2hQlyRAyp0nTjd2rjy4rxoZrzCF
 sX0afnCt80wUUq/iSGfCB4h8TETyazHEg4UKWmkXkLD7F0i+ph8rgmwiWThNPvzM391PoLFBBab
 H71oIE4gNvWR0x1Z9IDZXimwT/0SvsIfXpVqv0rMjk0RNrCkLm30szSvwySZnJ3ZfPMRyDo5atF
 kv4SjHlvC1kmGPifY9WarYFjFBP1twCNBiI50zWw+PUsrkPGCff31jqbQuec0BC8cbpop1/hQvv
 lAjTdBhDVNS1oh+KHEahwRR0c43QuCvs5TEm58yPZs76eG2fUJ5HCGXJeKuu+qc7uVzVyxysbPy
 reRXTKUeqIx6q3ry2ok4mzNi9J9sdO04Nkwrp2xGq9VJh87OwP0pLpcdV9yskzGQ+TE6ZRHSVhI
 LLWlwW
X-Received: by 2002:a05:600c:8b32:b0:485:4394:b0e with SMTP id
 5b1f17b1804b1-486fedbad16mr28909195e9.12.1773995196384; 
 Fri, 20 Mar 2026 01:26:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8b32:b0:485:4394:b0e with SMTP id
 5b1f17b1804b1-486fedbad16mr28908105e9.12.1773995195001; 
 Fri, 20 Mar 2026 01:26:35 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe6d923fsm78746285e9.1.2026.03.20.01.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 01:26:34 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 20 Mar 2026 09:26:33 +0100
Message-Id: <DH7GT9F8LMI2.2XMBKLJ77AL6N@redhat.com>
Subject: Re: [PATCH dpdk] net/tap: add software MAC address filtering
Cc: <dev@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
User-Agent: aerc/0.21.0-127-g39acbf663345
References: <20260319221034.703656-2-rjarry@redhat.com>
 <20260319154335.60e6406a@stephen-xps.local>
In-Reply-To: <20260319154335.60e6406a@stephen-xps.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f-PLjcCIm1jvtRZL_C3QNTKHpHO3OTUtQhAjGwkDgws_1773995197
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Stephen Hemminger, Mar 19, 2026 at 23:43:
> TAP should just always do it. TAP should behave like a real NIC.

I would also prefer if it was the default behavior but after discussing
it with David, we thought it may cause issues to users who assume the
driver will receive all frames, regardless of promisc/allmulti.

I will happily submit a v2 without the opt-in flag. Users can always
enable promisc if they want to revert to the previous behavior.

