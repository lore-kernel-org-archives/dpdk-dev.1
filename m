Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C5CCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 05:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BDA8402E1;
	Wed,  5 Nov 2025 06:11:35 +0100 (CET)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 056EF40269
 for <dev@dpdk.org>; Wed,  5 Nov 2025 06:11:35 +0100 (CET)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4e896e91368so75076581cf.0
 for <dev@dpdk.org>; Tue, 04 Nov 2025 21:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762319494; x=1762924294; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0KsU6aGaCEWh6EkhSTtsPLinpZVQAFiRcUCMPusEfg=;
 b=hgtyYr/jwJstli3FtTIMLLfNwnWYWNd9xZGVvuvRTGnFeNge+AiR2QK/JPDo8KWOWS
 QuPcZpQoDQLQVzseXum6+Z9yXRh57yBihnyTqlIoLLBdf5FU8qp2XWstBOHgaecu3HY3
 8X2AQ1Qh7ptUSDRDsavuGz0knI0YXmWFjamrYBEs6+oln7cs1ljRa4YaY1sQhIsz8lno
 a6H1OFOe4Ht719xF0cG1Mrn1kFHgT5C9scK3iZYzm+f8SJa8jAB70BjGWhuE9CtlOguI
 gTmJasxlY6wa3iNYo6rMD+LVurUkqKf8OZ+IoomLFXGzW76EdrkXvOZOYzetzzE1h65b
 CgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762319494; x=1762924294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0KsU6aGaCEWh6EkhSTtsPLinpZVQAFiRcUCMPusEfg=;
 b=tbCUrKoheOdXIx5ZX021xLOeDTIPrFwi1JvnpK3Emza9syNHbZE9/1iIbym6symN0j
 r2LhGslGPn7b4h/gR1OKOe6PRqDwT5M0nADxTrbpwnRENhxSheN4yh+vqODQFK4dBmdw
 swflbyPwzoX3mKqj0MNX3ZSjywqsYHIQ7xr56cP8m1mEzfDFiMlg87SHtomvhu8ZuQiG
 w35RqpFPul/ThgXrCXUVYFT2KRxCc1n/9P5SyApvZ/v55EcW/cucFhAmyyW5CtJoHXXX
 piI3ARVZgbe5lBdZmUe7bqd2EOFQ7UnHTttak+j2MmYjkeAQJMJTsRte2GLIthsgWEi2
 jfxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/lJ1OzE2aF7xr66zddoXipZhpsnKCRuxuo7VcTS/TDoMf42vn2EXOxReCrs+uYJRWcws=@dpdk.org
X-Gm-Message-State: AOJu0YxvWsAaROc7HgtyWlnsdDG2UAGh6bCxZ7T/ci11FKqRicb0ttaV
 XcQXOql/5CyHV/qnesvhF5e454lwHlSpfeGC07P1iA3GboTFfpyvaoEBJaKKg7zxu8z2jQ3mgZH
 j8Qx+aesEoqGzyxmfTwhT3yaSYy1DzSc=
X-Gm-Gg: ASbGncv0Gy00TVWNeaD9r81O++KcJzSOdTcV2b2g849Url0TEhMIQLcEKNw+r4fvt8r
 zBmKXWrzraosRs+xPf+/D/IRq7W+pBlWlEosrVtAI+2ImaNMfNimEQ5IhJcJ1ncJNZ+C1P3eUTY
 9hg0J4auYS2H1HnFYQ+plT9eGKMBRDgPdsL6+KomqmeiQHkJ5iHH5QFYZt+B6S23dDPGWDRexqd
 S+UkA8wHllga1ea0eODV7w/BtBCW4G9l+qVgQbhBooXDGyJ/tXKQID0bHI=
X-Google-Smtp-Source: AGHT+IE7FuRKDoxmTqjMgdMjEtiKDxFHRgWdCYvqXD6YIxwhoIV7n3/w9qoQOaaguzVony70D+EQjKtb1PPgYs7piXA=
X-Received: by 2002:a05:622a:110e:b0:4ed:7074:423e with SMTP id
 d75a77b69052e-4ed723759dfmr24380151cf.28.1762319494167; Tue, 04 Nov 2025
 21:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20251006051402.1387576-1-rkudurumalla@marvell.com>
 <20251029130023.1637177-1-rkudurumalla@marvell.com>
 <20251029130023.1637177-5-rkudurumalla@marvell.com>
In-Reply-To: <20251029130023.1637177-5-rkudurumalla@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 5 Nov 2025 10:41:19 +0530
X-Gm-Features: AWmQ_blbiXWUs_9p-5UL9wJGpkYSMOEjzdh6xV4rOiBb5M6v7y_XkrxrEQAaaHw
Message-ID: <CALBAE1Nboip1UhNtQkUTkdPareKEekzJCniK7E3WD1s4sWLr2w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] net/cnxk: enable CPT CQ for outbound traffic
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org, jerinj@marvell.com
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

On Wed, Oct 29, 2025 at 6:31=E2=80=AFPM Rakesh Kudurumalla
<rkudurumalla@marvell.com> wrote:
>
> enable CPT CQ in cpt instruction to read outbound
> error packets from CQ
>
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Please fix below issues. Good to merge next version

Wrong headline prefix:
        net/cnxk: handle soft expiry support (expected prefix "drivers:")
        net/cnxk: enable CPT CQ for outbound traffic (expected prefix
"drivers:")

Invalid patch(es) found - checked 5 patches
check-git-log failed


### [PATCH] net/cnxk: enable CPT CQ for outbound traffic

__rte_packed_begin and __rte_packed_end should always be used in pairs.

3/5 valid patches
