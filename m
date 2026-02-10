Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5171EA811F
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:24:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A70A400D7;
	Tue, 10 Feb 2026 15:24:39 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 57622400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:24:37 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso56725985e9.2
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770733477;
 x=1771338277; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UAj5iZQcXK8q2AOjNtm4N5ixqmsyIbjnFvnqt4mLiI=;
 b=GeWb1QffymuxBzzqYqx2cqYWSL1GEPg0Iuhzwu4tBb0izI4DqLFf82UTLhfbsyigQP
 pIbZE/OwzVp2n9niROLUCFOKvwkj5/HRawCJ8Vb6iZpKwL4EFtTu5svQO4HbNA1Sf0au
 Yin09rCcIeQZbEPuCFtYoOAvItkN/zofoon+FNhe0zuKiuWFtN+ZvaJvCBtzIDL/UWbW
 bFm1jltwBdLwA90ap7spy0i5foTbZubmZ4R3GcuW69XYrYijAQBw2rjHMIQhaSUXqBbu
 q6MrQAcNkRFpN9b1gsiB4pSdjlYBHQ0oGr7QdO6cqJE2sy9dDE+XxPz2APeynPyAvpPZ
 xJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770733477; x=1771338277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0UAj5iZQcXK8q2AOjNtm4N5ixqmsyIbjnFvnqt4mLiI=;
 b=AIDpETLB/vpWiCu8BVMKVhKjXlWU32eSQ23YuyikGqD3S8HxQxPolU2eubwbJm2fZh
 HpFsmOFU9nC0UcC8fFoUj6RzjCBjpLytonN5mI5SAsatLgZF8+nGMRZ9BaSfhbqWVkRY
 aXF6FwVFWSNWMFeKJPyLzHZrz5isf9/931T+FYK4vxGFkYnFfEtgtvZoe3xboXSExZOM
 3rr3FSB0pTstzjUk05jsef022kzYFxJTICEWsjGfXhynF3D9kk22s62qSOTDUPjwUjTc
 2Hz/4H24AnaGmoquz6rJHGymqnNi8Q8sb6e8mcKd/bIB//FD6/tWE5sO8ydbTnS3kL59
 m1EA==
X-Gm-Message-State: AOJu0YwLqnDrTorYasacWhE3JeW+SQzMx+z69Hp+U8kiU4impQuXTftf
 N6wBZ7SC34imtf3MC8TfZNKWYNC/q+RMY/ldR6zCXxXJ/h+KSWLZ0nLjko5xLG55qQU=
X-Gm-Gg: AZuq6aL3aX/BK32vHjBniyEBwBj/i6puAxLATo/kwRA+DV1Bjy7Ile0w13H42QQvtUU
 4Jyem00cZP+lY2aYw/mDBBGhTbQ2HZ+D+PzHd4dAN3jZ0SPU/fK8n0n/0gVIu7xL+lSwVv7ryHe
 tWroAZ1rXvav2CpLOlnVSBFqmVwcIvWdhFzzp92ZOLNU1evc3q7VnoUCNgID6Bdm/s2UYnmW23H
 HAIlaIHVgbTj19T9kSqRrfvEE2pBauNP8wAOlhpSMvsRh9Q/1wFFPfa3hRcTSO0k/sw0ikYXp9h
 YqptbKP1dCC2zhJ1/pt/rt8sV8sR9dc2Tp0/CARVwiAw6bIi5h646nDwiDHBKIRmM5Ju2RxEtQc
 bfNzbn8vYYu5ttrTLbW8olBF3gECGDPX6aBTFoxd9gtBaZAA3EvRZguxzyGTjP7RUmJo/zWU2Pz
 l21vJj/oZfjDXoI0P35Sh2ngOYcRC5ghPbTgXAMoQ8hSlZXXaIBBq4TquKh+1IR3qi
X-Received: by 2002:a05:600c:a00c:b0:480:4c45:aff5 with SMTP id
 5b1f17b1804b1-4835083339cmr38676115e9.34.1770733476658; 
 Tue, 10 Feb 2026 06:24:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4c4sm109079125e9.10.2026.02.10.06.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 06:24:36 -0800 (PST)
Date: Tue, 10 Feb 2026 06:24:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhanibek Bakin <zhanibek.bakin@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [ethdev]: question about the experimental functions
Message-ID: <20260210062429.6c1b4230@phoenix.local>
In-Reply-To: <CACRNuqcKD6QucokYg=O+WoGXGnMwTEkYWyjyeoxKDoT6_BB1RA@mail.gmail.com>
References: <CACRNuqcKD6QucokYg=O+WoGXGnMwTEkYWyjyeoxKDoT6_BB1RA@mail.gmail.com>
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

On Tue, 10 Feb 2026 10:56:09 +0500
Zhanibek Bakin <zhanibek.bakin@gmail.com> wrote:

> Hi there,
> 
> I have a question about the experimental
> functions: rte_eth_dev_get_module_eeprom() &
> rte_eth_dev_get_module_info().
> 
> From what I can see, they have been marked experimental for quite some
> time(7+ years).
> On top of that, I don't see they are going to become "stable" in the next
> DPDK 26 version.
> 
> Can I know the reason for this? As I would love to use them, however, it
> would be a shame if they change any time soon.
> 
> Thank you for your help.
> 
> Best regards,
> Zhanibek Bakin

Almost all functions that have been around a year or more should
be marked stable. It is just that nobody submitted patch to change
these.
