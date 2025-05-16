Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DCCC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 08:02:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CC7A400EF;
	Fri, 16 May 2025 10:02:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D5AA740041
 for <dev@dpdk.org>; Fri, 16 May 2025 10:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747382518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ez6mIa8lfZ6V6xdYUBvIy1zq1ueMb0e6qUIs0EG5rBM=;
 b=g8X3zeVL8/bcV3MDs6Lb3x73PO5QiSYn5h3/RJ6j3Ax2qpdp0h9NRmBCWKgoxFErNzowlX
 YG911gWJcTLYuxEjgLnSeNIqeYdN4DXnHRwWzIpCATceD8UHMzaTDMawXsY7ioR0uREAFh
 TO8MgiI4arM8B9qDUha04cNm6Hxt5fo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-n4yDpTQPNSuPr-n75ArDMw-1; Fri, 16 May 2025 04:01:56 -0400
X-MC-Unique: n4yDpTQPNSuPr-n75ArDMw-1
X-Mimecast-MFC-AGG-ID: n4yDpTQPNSuPr-n75ArDMw_1747382515
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-550ea022c07so208185e87.3
 for <dev@dpdk.org>; Fri, 16 May 2025 01:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747382515; x=1747987315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ez6mIa8lfZ6V6xdYUBvIy1zq1ueMb0e6qUIs0EG5rBM=;
 b=RDLh+IN1xDtx7gUsHiemLaSY6MxIDHOf2eqiwFQY4eLiUSyRP2N05YvGd06/LZU/ij
 5lN38o0BvkcGeSHBYN4FKSForgJv80omm9ShIe28AH7jbQkzRkz/2snbqDAjS43f7Vyu
 6nXsKa2RJDuE3hDsCubFGesZ1r3slkDgtlJCqBs3cdcNIW4f4iqIn+HneKHgeD6ZJhjV
 rpaW7R6q9d9zNq5B7rzwGkbXbdsmGI81wktnbblmvhNjI/05q5KTMHuNnUBO/vsocoDM
 XrA9MTsoKnMBajWcoMZRlO0qF+f4HiyXOSuF2NP9yvv60t3TqsaqwS5kQOX78F3sz46U
 0EuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCzoAk/dY6JKzH1RkaZ7Erby4R9N2vzX9yKctdfwi2v7DyBMhkpDvV9Ls1QR4+Cygo0tY=@dpdk.org
X-Gm-Message-State: AOJu0YzoCivm0lzJg0RCHQ6rgWvd6rfmb2sB56MDUy9al6zq6XaHuj+9
 OkxK5iyMEdKXwH5TYArYkwoBcELmiJUKRL/tUZuSfiaOJGW4dKVmenHC6Z+bj/6wymUYk9pL0gA
 kH1bXcdmJ9nSgkhbIQCNAkFzhuDFU+kTNQH92JkZyxNIGQTnWL0r941BEd3Ali+xLJKuLjc2UWK
 n6fdR/M63pWBSJqdX9bsk=
X-Gm-Gg: ASbGncuL1B4YDr3bSC+NVE91QN/9Oro1lEFl4uveinoXCuZdO7+wlOdy0x0n9b8q8Ap
 /P1+HiVNtqvx/zywSoDMErJbGtbApZQfSJBW4qNMtU5lnJR6fixaWDuDCV6b3WmuMhN0od/U=
X-Received: by 2002:a05:6512:138a:b0:550:d534:2b1a with SMTP id
 2adb3069b0e04-550e97d8c9amr470552e87.31.1747382515303; 
 Fri, 16 May 2025 01:01:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqmwfLGDvI0GFj5lqWFYj6FDCLqzIEcElF0kU3sL0W/iO7Vq/l8gTeBhkDROuLqdeqVz136TxKeHj3a1CPqtg=
X-Received: by 2002:a05:6512:138a:b0:550:d534:2b1a with SMTP id
 2adb3069b0e04-550e97d8c9amr470531e87.31.1747382514826; Fri, 16 May 2025
 01:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <1746827534-19881-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1746827534-19881-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 10:01:42 +0200
X-Gm-Features: AX0GCFvqppJNd8RPD9faRbjFeA1FksPl4gaxzmD37odmI-qi-E-GzdTJwXpE4qY
Message-ID: <CAJFAV8y8vibAGFsAR1XPFedR0-q+KC+Rm1=2cNPyJ5vF3ATKfQ@mail.gmail.com>
Subject: Re: [PATCH] regexdev: enable to be compiled on Windows
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Ori Kam <orika@nvidia.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -U9-jEhCSugyFZFAgORKz5M8WiB53VZjTXG3vqxcAqM_1747382515
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, May 9, 2025 at 11:52=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Now that mbuf is compiling on Windows, this library can be enabled as
> well.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

The test-regex app can probably be compiled too.
Yet.. why do you want to enable this library on Windows?

Support for this device class is defacto deprecated, as no vendor is
providing recent hardware implementing this feature.

Also note that it was not built with clang on Windows so far (I did
not double check this assertion, I just based on the fact this patch
removes a is_windows, and not a is_ms_compiler).


--=20
David Marchand

