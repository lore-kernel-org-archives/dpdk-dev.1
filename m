Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD6C606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lLYDi/ZC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFC2F40285;
	Tue, 10 Nov 2026 15:33:29 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTPS id 25D5A40281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 15:33:28 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2ed0b03ce3eso8489345ad.3
 for <dev@dpdk.org>; Tue, 10 Nov 2026 06:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794321207;
 x=1794926007; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uDuFXAeXp4MbUL/26Jbgo6Izb0cpJ1xR75rZEoQslmA=;
 b=lLYDi/ZCfdYnUAYCpzEsCF5AA8ylmS47lf4KR2/oejIhKrq9GNSXYhSU0Abt8bwrtg
 kVmOF/scmpVS+wP442JWNseSIUeCuBHtJcRLxwUOPqZe56QkM6F3q2iq/mgwSG31T2I0
 WHY+uXqqkp7Xuca39zVYPN9UnmaCOZSCoeUgmpLslxC+eKu5n3D021EQ+4FjBP7jcJfQ
 Wt/RyBAefObnaF4K3kvTPx+3UlR2qaatnU/lJm+GUrHFIsZwnWKUECe1NmYgsfd9I66B
 fA66p8M2nvCHpFS9T0SKuv3+jbj3bl6oXsYVLeL/jioW7W0gmwj/d0k632VH9i2p/et8
 CGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794321207; x=1794926007;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uDuFXAeXp4MbUL/26Jbgo6Izb0cpJ1xR75rZEoQslmA=;
 b=k/2FXyMyns4ejNQQ7C6vESbl5LqtwPPi857r9yiLOOAymlKy/SKmnPOFyLTL7wNXld
 M5tdKuDWc3Idq5lw5Bb6VHk49wBdjaHmmbmUJdeQCqsEvoXcivVN/CMKeRmM6ai3Ltym
 r/rMLIefBRGvpQk8D9Dux0JdMQisCNPCI75OXXZM1Sz5MMEShUZr8RAW7ZZIXP/SjPdX
 q0ayFWnDFaw8FxjW/O7hQDXbDOPbK4l1idQQX5zgZyEH30srZ1jn76qh+tdUzqkKuclh
 lvoXj/szn8MNtSla7E/JweiotC2DVR/nGrTILyFI38EmNW/mhR39SOYUsTgEmwkyeCiM
 xHtg==
X-Forwarded-Encrypted: i=1;
 AL+hErF8BizFnWMAe78qSwGBqpDctugaxy47BC1SOWySXpEu8qOAV+ZH0ryptcnlhzxbNcwN7hE=@dpdk.org
X-Gm-Message-State: APuU4Z/TEEP0Q01w3/EJK3fne9MHOzNv7HezoXt/iN5ARtVJ5bDWGdTD
 nWqYbihQ/H7l5frs+u42gqiLQCxXdPjMxqSATtwdmMOvCiRVE8QB1ezFFmb5x3Mg5Z8=
X-Gm-Gg: AYBFou0nit54TAlTY9os3Osu7NWwgmFZgo+BEsb+sC3II9o6KHZei/2etLjai+RKt87
 CNlpYS1zWsj5dVSJEd/t8YVPlAdqtNxREREYJAn7KKw3uXDyt/GaABNfU9kvmglhODNcGL50NPd
 KAZsBXqpQJNxSE0PPtNWHp4madG4anh/z41/OjL8Fnork19VimDkpjW5fXR7pU9ymQw75CSSMBL
 HFLJBIqXYTE71KrHyasQw/3foCwUOBXvLwlB8O5mgR3OcAy1bY1qSWhbaEOTcZDob5Kcdnd6Uje
 d2hlDBwqvyOi4a8D5a2BiMmehIUgaEHXXT4W+XNgvpgO/ki38IwHz7hWZHPLGdtmQ7rOS4xt68S
 5iFN1NcnTq63HwjqgD8Typfvn6tfS7WxbSXb17zx/2oBrA3n9I1xyfsNEr35sEy/Y0XLa8qkxma
 eyd4AUfdkAjSdcfVt3CM3ihfLfNyQodhYCjAf6h2i3iuvAlese615xGsW7ko2NRSGcqKZ3mvem7
 cb4lOogGh7xFsWhNE//ZXzJ29zMo9bO4PtMF8XFIuGiVaJgW5Iwr+zW9g3KDT3CXD7z2nTF7ojI
 DVv0n+m57STB5OV9zn78GW9xD4zDud9bBKYEPXPSN36JJ7V/PyLh6Hxttbi41AY+ORG53jK9
X-Received: by 2002:a17:903:3586:b0:2ed:4e76:854f with SMTP id
 d9443c01a7336-2edb9160de0mr27183385ad.36.1794321206851; 
 Tue, 10 Nov 2026 06:33:26 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d9ed10sm9583645ad.49.2026.11.10.06.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:33:26 -0800 (PST)
Date: Tue, 10 Nov 2026 06:33:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Orgad Shaneh <orgads@gmail.com>
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@kernel.org>,
 Aditya Garg <gargaditya@microsoft.com>
Subject: Re: [PATCH 2/2] net/mana: fix Rx interrupt enable failing on lock
 contention
Message-ID: <20261110063321.61b422cb@phoenix.local>
In-Reply-To: <20261109140207.4029126-1-orgads@gmail.com>
References: <20261102070809.813033-1-orgads@gmail.com>
 <20261102070809.813033-2-orgads@gmail.com>
 <SE3P153MB18482F1674C5450AC402E0C5BB732@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
 <20261109140207.4029126-1-orgads@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon,  9 Nov 2026 14:02:07 +0000
Orgad Shaneh <orgads@gmail.com> wrote:

> static int
> mana_reset_lock(struct mana_priv *priv)
> {
> 	while (pthread_mutex_trylock(&priv->reset_ops_lock)) {
> 		if (rte_atomic_load_explicit(&priv->dev_state,
> 		    rte_memory_order_relaxed) != MANA_DEV_ACTIVE)
> 			return -EBUSY;
> 		rte_pause();
> 	}

You need to use pthread_yield(), rte_pause only generates a CPU rep nop
which yields to other hyper thread if it is another process need
to cause yield in cpu scheduler. 

> 
> 	if (rte_atomic_load_explicit(&priv->dev_state,
> 	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
> 		pthread_mutex_unlock(&priv->reset_ops_lock);
> 		return -EBUSY;
> 	}
> 	return 0;
> }
