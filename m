Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29190CA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 14:49:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F17F427A2;
	Thu,  4 Sep 2025 16:49:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A6C594279E
 for <dev@dpdk.org>; Thu,  4 Sep 2025 16:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756997360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62xuJpprAO7E6EkVVc8e61U/qlj4w+vsMKseUidY8dY=;
 b=PUmPWzo+sl/FdpfThFa0aZ2X7px/XCDcIePH4C0mlujrY2D45qi62tdwUyd0Hi6FvV26lB
 bkTrLXsaUc1vvaTVN8yHtuLSHde9Y3/OpxqR/NxYot2Hxd2IPwJOn3xCO/3fXMMnEk5C0D
 i/d2Aq3VhyfUheB4QmQhQ4FbOEUYN8U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-oEw7nOleOI-YH9HDKQKtQQ-1; Thu, 04 Sep 2025 10:49:19 -0400
X-MC-Unique: oEw7nOleOI-YH9HDKQKtQQ-1
X-Mimecast-MFC-AGG-ID: oEw7nOleOI-YH9HDKQKtQQ_1756997358
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3dabec38299so693412f8f.2
 for <dev@dpdk.org>; Thu, 04 Sep 2025 07:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756997358; x=1757602158;
 h=in-reply-to:references:user-agent:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=62xuJpprAO7E6EkVVc8e61U/qlj4w+vsMKseUidY8dY=;
 b=lc/PB33jTp8xX8rn/LGHiIBx2RmVSX/5EXMBqCtrkvj7HXaGlqLLJswSJtRF39HVa3
 /NGihK8tLow0+N8SXiiIZvmhbwhEgex3tbWoyGmdzcfrxFduF+vmE5k8PrFPp1oXiE4L
 XtrR53RdEk3VSP/ItPQOsuOCQv3opRdVnZN64p+5guFTHMOxkxyCXdAx1EScjvmwOUZU
 5uwUj1cmh5BM/Gib7YnVMUIgwsvlUFYuX2sTQjMfcVE2kHyAvTp4i2vivWQUOwOyd9qE
 BWQNRw7lbRl7lw6JMNZfnZxmYUl7vXPLSs1XkYoLssUQue1LQqS8YyMZCb+czpMQHirh
 OUCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBoqVtUpmCQSTdJgimOnAbCO+Y2Nq3SXQdZqCv4CVRbd2M4MZX8ZYdqCAgv+oYIec+BUk=@dpdk.org
X-Gm-Message-State: AOJu0YwC6t4tpdPmiO0ZyCcXgoWqbr+lPA3GrNAXIMWojuIoyPfvWEVU
 rzonX1r3iTb5Ck7x+zJrJ8CbLaAvC8h9xNk9WsWGpP7uWa8Vt0Rsfg0Q0cylfTIqcgvR7xZ0NDn
 e3HXUn5hfdpi6WgzQQa/l9y2Q7tFh2HPg9vLmdSN/GauhVby81B4o
X-Gm-Gg: ASbGncvHlwt7jreM6ENZR7z25ea9gce0JUUNcg1gFacBkdnWMxzZjnsrLEXvJXF7mfn
 QZGGwQEl9maOH8psWvdtylUsoEzaiym6G+7nXhN+IFsoY9FFatSm5Fc8L5bZTjioD6sX+FU1f4T
 oTBOcJYeg9ONa0qgkbhi8W7TSfexWZig/bQClndNbWpHN4MqYEPOClT5Z0uZr3li6iJ+byapp9j
 3OMr9Zvei6YDe9Qj0qoU5F/arm7fGckcm3E7F2Iz2Tl2VYEp7JkSHlKgFACE+0tBppaVzhqEgQB
 L95GnxMYa2x/DOY4TId25KFB+PQgsRwe7SiIB3EBhC1X3996Wp/MNAkBw8FKgOQ1q/QBzTHXfzU
 E8ihKUqVarkYQoye9sNnopA==
X-Received: by 2002:a05:6000:1449:b0:3da:37de:a3c6 with SMTP id
 ffacd0b85a97d-3da37dea762mr7307578f8f.59.1756997357665; 
 Thu, 04 Sep 2025 07:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPG1AU7M32HZJdj84EP+Eq/TzfAWx3zY1zorebvCwFBw+bN/NmUOXFGDpbaSiyMS2/09Uj9Q==
X-Received: by 2002:a05:6000:1449:b0:3da:37de:a3c6 with SMTP id
 ffacd0b85a97d-3da37dea762mr7307555f8f.59.1756997357104; 
 Thu, 04 Sep 2025 07:49:17 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d701622b92sm16687155f8f.58.2025.09.04.07.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 07:49:16 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 04 Sep 2025 16:49:15 +0200
Message-Id: <DCK3KYFOL7EF.1CBE546ZJUS04@redhat.com>
Subject: Re: Error with --no-huge when compiled with -fsanitize=address from
 gcc 15
From: "Robin Jarry" <rjarry@redhat.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, <dev@dpdk.org>
User-Agent: aerc/0.20.1-134-gd0eef4107798
References: <D9WNYZDZHISG.3091PEP8Y34QL@redhat.com>
 <DAIPCY7NIG04.2Z0S17M8BPQUH@redhat.com>
 <9d2e0536-98af-4532-aa57-dd1605d6e070@intel.com>
In-Reply-To: <9d2e0536-98af-4532-aa57-dd1605d6e070@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _vx4Kirf-dzyp6ZtxaQwrtQrHaolCJikLFEevj5HX7Y_1756997358
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

Hey Anatoly,

Burakov, Anatoly, Sep 04, 2025 at 16:35:
> I have been trying to reproduce this but I'm unable to. I run some old=20
> CentOS so I built GCC15 manually and tried reproducing with that. The=20
> version I'm using is 15.2, could you please retest with latest GCC15 and=
=20
> see if it was fixed?

I am running on Fedora 42 that has GCC 15.2.1 and the problem persists.

> (if not, I'll try to get a more recent distro and reproduce again)
>
> The DMA mask checking you're referring to is there for cases where e.g.=
=20
> in a VM the emulated IOMMU will not have full address width (39 bits was=
=20
> common at the time), and thus we couldn't use the full VA space for IOVA=
=20
> addressing, and had to resort to using real physical addresses (because=
=20
> kernel ensure those are to be within support range of IOMMU). Were you=20
> running this test in a VM, by any chance?

No I am running on a physical machine. I tested again without --no-huge
and 2M/1G huge pages, and the issue persists as well.

I tried both as root, and as a regular user.

--=20
Robin

> Formatted to fit your screen.

