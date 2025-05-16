Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4FDC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 09:22:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F537402DE;
	Fri, 16 May 2025 11:22:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4DED9400EF
 for <dev@dpdk.org>; Fri, 16 May 2025 11:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747387343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReYyegg9q6M27VdWx3Wi+iRZ7ETpAuh0x8bV3PMQoyE=;
 b=YmMmrYtrqDeR69gpdbQslS2T8h/2tpirpLzUFoYTM+NPjxSO62XuhWpE1DwS21tk7U/ceQ
 gCNs3EBscojdOZtPaeHv20QAoL7sBGhSlBSbkA8HR3MrnTQ4ZVj+4B0wh/DZ7unlPmNxt8
 n9H+xUvcXzWOwerXpDjhbJOLiSROSVU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-MniUtqI1Noishgooby3uFw-1; Fri, 16 May 2025 05:22:22 -0400
X-MC-Unique: MniUtqI1Noishgooby3uFw-1
X-Mimecast-MFC-AGG-ID: MniUtqI1Noishgooby3uFw_1747387341
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-54e8141b4adso1320998e87.1
 for <dev@dpdk.org>; Fri, 16 May 2025 02:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747387341; x=1747992141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ReYyegg9q6M27VdWx3Wi+iRZ7ETpAuh0x8bV3PMQoyE=;
 b=BH9GJ9E4j2thbHf5QOFj7vSff9UvLMKka6VJeaoHDaf/XNg+P3z3bNYehqUV7AOaWw
 xNf9vl0BPsqx6Qx8+uJohjQu5+RowE8PNYgGew7pLF+8aLLx0R0bKwS6dnCIlrrFXjER
 739jvZDexwlYiFCMfiR2vjeq34Jv6Nj2CCVojSybhiFb03Mdxmu2wY7gpsL43aWpOiIB
 e2Xv/fsSnI+H/ftBavSr45D1P9c1c+dnWtCf/DN6PS3gKS+SIaKz3G+Lw5d03+qCS6vF
 vvzdDBK9jPZ5orBQscLWldmu5m7NmdFAUgnzUVoY6CkzS8Z4Zhk6k9UHZ/PrXURHsbb9
 JgEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN/nOKOEsS9HNw8Ljdd/J1TIw21aQ7EAhwkL6O289GXaH2GZjV7TDbhkfpLvT4zfeALJA=@dpdk.org
X-Gm-Message-State: AOJu0Yxxh55HrsatszokogJ4jury5RPMJqs12w/cDPfUopxY0lZIsoQL
 eZq+YsqGPjXMxw43CbxWBMoN9P1oMB3RYUWLe/Z14G01zggGe0gY2EV7+I4J/FExqDyi0r/byFq
 FxStMq1RYbMoOtKSWhTpHNHGcHRtZ+ekDlfn5IzUe4xMO9XW/mgO0dC3Fkj32PsJcWMKB5agWVe
 nzv9jEc+5h73LngrVVqYU=
X-Gm-Gg: ASbGnctdaXwPTs2A2ZpqRZKgx2aTDCnDCSUbE1BEsgjFbH5jpjiPykM0/X5QpLr1+uq
 RVH8NDRe9+X3tK3y4oa1OXezgUOJCb0HdfJH9PYuvXA3ahwyPBhG4Xe6PyaIvqK8n2/8w1kU=
X-Received: by 2002:a05:6512:3e28:b0:54f:cc0b:158e with SMTP id
 2adb3069b0e04-550e71e6ccdmr702703e87.31.1747387340663; 
 Fri, 16 May 2025 02:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXy/DwSs5/LLAQN7XYf3rQhjSqlbfGrvd1FGyhvqb7WufQveQ1penrOC34ticWIhNnAJJ+VgrRprcxIFMgKo=
X-Received: by 2002:a05:6512:3e28:b0:54f:cc0b:158e with SMTP id
 2adb3069b0e04-550e71e6ccdmr702639e87.31.1747387336884; Fri, 16 May 2025
 02:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 11:22:05 +0200
X-Gm-Features: AX0GCFvrwpqmpr2A45vBOKWjbcNsBf_x1BiImLCattbI1Hik6c_emVvoGFW2z_c
Message-ID: <CAJFAV8z-FM5Jaw1tcVu0KQGoaPa7gbpvH3GjcVDEdqSF0Zn47A@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove VLAs
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T3lXLOIbcSa0nuWAFCOoPO6Mlqapcdvl7O75YLKnAxM_1747387341
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

Andre,

On Fri, Mar 7, 2025 at 2:40=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> There are two lines that were using VLAs, which are not supported by
> MSVC.
>
> 1)
> ../lib/rcu/rte_rcu_qsbr.c:326:12: warning: variable length array used [-W=
vla]
>   326 |         char data[dq->esize];
>       |                   ^~~~~~~~~
> 2)
> ../lib/rcu/rte_rcu_qsbr.c:389:12: warning: variable length array used [-W=
vla]
>   389 |         char data[dq->esize];
>       |                   ^~~~~~~~~
>
> The short-term fix is to use alloca, to allow progress with the msvc
> compatibility work.
> The long-term plan involves API changes and therefore can only be applied
> with a new release. This long-term plan consists of introducing some
> reasonable limitation on RCU DQ element size.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Afaiu, enabling RCU with MSVC depends on this current patch and a fix
in test/ipfrag:
https://patchwork.dpdk.org/project/dpdk/patch/1741313581-14300-1-git-send-e=
mail-andremue@linux.microsoft.com/.
Is there anything else missing?

If not, then I would be for doing this enabling as part of this
current patch (I can do this when applying).
WDYT?


--=20
David Marchand

