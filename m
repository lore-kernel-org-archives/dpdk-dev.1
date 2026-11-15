Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6CC606A32C
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aF/FQRf2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 940AE40150;
	Sun, 15 Nov 2026 22:48:00 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTPS id C47F4400EF
 for <dev@dpdk.org>; Sun, 15 Nov 2026 22:47:59 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e8da6ef7ddso13540905ad.3
 for <dev@dpdk.org>; Sun, 15 Nov 2026 13:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794779278;
 x=1795384078; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Th6MwKh4lmN7yq3l/SlEL8TDEv8dBRrYCsKhel4HXFU=;
 b=aF/FQRf2pTxF9jK17jB3zxDzWV+qY4Q5UjEY4Mv/mrLEMHqwwxvxVSwaOl+I/ltYRO
 aQ5vTfdXMpsyXtmBs5MVKL8NLJqeSQV/yTxVc2JHGawbuYZZJLKSto6xxi8Y56D4WTLS
 ACtkmfoyyDGKEW44/EUCNiUvOTKuSi6r1hBdDeNEb8HUFKvafK12T5eW5STa2kkFrnHF
 uZq+WRdNKLDdvxUmYdyu8A0mBFPy98dPzWgHHWHWDAoWnDcIVM7DiRj8apa7ZT73KzSq
 vkXU/zOQ3w9p7KZA3NWUBLex24O1iHHTO7RJl1zzKGtByS8m7nXRCLulzhpWvPLOxBxe
 a4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794779278; x=1795384078;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Th6MwKh4lmN7yq3l/SlEL8TDEv8dBRrYCsKhel4HXFU=;
 b=lLPVFVvnITGv6WVWPDsroK/IWpbfwi/CC4uylCgayXxce+01g4D8qD9QZZMxjqkZng
 qt+Ky7BoEnDmBCSCJtesWrOctOkbdCZuYAsJ1IObyMU5hIBFtOag7bSY9KKqwuplSNhg
 b23Zm79WgaM1kdYS4xcMzc/ywNdcM/HFPhJLu8ufYeYYOH4HrgaNRXNaOv8QHYtntWsu
 hG5O5g3wnuAreaFUH+Nrc/wNOklSvSxS4dblrbZqBSmJSb20isSWiSK08f9jFGxT/V5c
 NtHvorYd8h/Z7uJpnghofByJgbtnTkm8taxYmb1bG134hYxWiFJziw1QwJPPTY9xd7et
 mmxw==
X-Forwarded-Encrypted: i=1;
 AL+hErF1qX82q7hGvvQDQ6KUB487Mutvd/EWQUU5ITQt+Lx66wyXmJeOav67YIroktvUc/oPrQ4=@dpdk.org
X-Gm-Message-State: APuU4Z/m1HxZ403yQNx0ogYQHBpOtnpgKJzEQZEn6LIdw/ckKlZA/WCX
 e+CWsPbKG80EPWZwUq97dPxOZa+3BS1KAQhExuYE4IVHG8vMpHb35u6dlnaJoRvIG3Y=
X-Gm-Gg: AYBFou1sLsBpsYNG9iKMUKsMgGOqobkrSLtJAbeUQ08SDE/r1jLb+aUCv7I7Lp34sfU
 trTW7sdzvqyO4NNX50iCIilODvMzyPn4D8vE4FSZrT3jNYZTEEFQi2Yyz7P9wvzz/jGe7e+iJjz
 aIiYZqnIy3cpR4uw8v3Zzl1x4LX59hgQzfPDnUhYBHQsjsaSFQeGm5TF7WyeFSPh7Hu+06JjpE5
 4bLtucN6G4NXDaqwSS63QT7t/OmFU4VH/Nyg2mERoSlxbJHBx9VD4ZVvsLg96eZMfKEBVd2Yc4X
 7x5I6puukI0GmCIQPx6FiqZpO59rENDAvY/NlUgqfjS9noazSE72jOVmNwoKJbh+GJ2ZadNwNNd
 Q39U+JiSWkjti4hdvjChmvINkuNzaXaAUT9jLrin2WFXKbL/0cPbIEwG7KP/0tMzq2WkFmKEhgs
 rPonX7RfpZPv1as5fqt+wlnY6EK1ueoJRsuLKR2ZihBgOKh/t85nVTkn1faAFXsNrwG/4aShPXI
 wxwipqTf6eFD+hQkqGgTvp5hA0W63+ZNJ5YApLgASDSmOTBRrVmAQ60CCy476VcoVxIYpPRBUdZ
 EMn3i//rtM3tRutA29k0TxFByNU/y2d6/vZxnZrgyRB4PLAzdbEDkyejjEaBUOH5pASAsr1tsQ=
 =
X-Received: by 2002:a17:903:182:b0:2ed:e93:71af with SMTP id
 d9443c01a7336-2ee0dc308c5mr93307195ad.41.1794779277976; 
 Sun, 15 Nov 2026 13:47:57 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0fa3ee4bsm29876265ad.73.2026.11.15.13.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 13:47:57 -0800 (PST)
Date: Sun, 15 Nov 2026 13:47:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bulatov Mark <ms.bulatov7@gmail.com>
Cc: Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund@corigine.com>,
 Chaoyong He <chaoyong.he@corigine.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/nfp: fix uninit local var in
 nfp_pre_tun_table_check_del
Message-ID: <20261115134755.1e3b3b33@phoenix.local>
In-Reply-To: <20261113142207.5537-1-ms.bulatov7@gmail.com>
References: <20261113142207.5537-1-ms.bulatov7@gmail.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 17:22:07 +0300
Bulatov Mark <ms.bulatov7@gmail.com> wrote:

> From: Mark Bulatov <ms.bulatov7@gmail.com>
> 
> If the search fails, it leads to a null pointer dereference when attempting
> to initialize nfp_mac_idx.
> 
> Fix this by adding a check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d3c33bdf1f ("net/nfp: prepare for IPv4 UDP tunnel decap flow action")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
> ---

AI review feedback

[PATCH] net/nfp: fix uninit local var in nfp_pre_tun_table_check_del

Error: find_entry is still uninitialized on one path.

  find_entry is only assigned inside the loop, and only for indexes
  where pre_tun_bitmap[i] != 0. If no bit is set, the loop never
  calls nfp_pre_tun_table_search() and the new NULL check reads an
  uninitialized pointer. The subject says "fix uninit local var" but
  the patch does not initialize anything. Initialize it:

	struct nfp_pre_tun_entry *find_entry = NULL;

  With that, the added check covers both the "nothing searched" and
  "nothing found" cases.

Warning: Fixes tag needs a 12 character hash:

	Fixes: d3c33bdf1f18 ("net/nfp: prepare for IPv4 UDP tunnel decap flow action")
