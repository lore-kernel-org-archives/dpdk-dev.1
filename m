Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF5CCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 08:55:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0807F402A0;
	Fri, 10 Oct 2025 10:55:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8CCFD402A0
 for <dev@dpdk.org>; Fri, 10 Oct 2025 10:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760086514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V331zmIgYL1KlkpdkbSKzYTs4FAePlvLzhY0vafj4JI=;
 b=at47vD65aEF9jC40uMIwQeqAE15Lmpc64B+rYywaINe6qSfNzLI86md/7eoKbhttMsFGNF
 FbTXmYgXtsjMZRyYpDApWWXvCjAL8/IuYI9DilH/8nqjKYLilIlbV7zGtoDsSxfo2u5Xfi
 d0Wff/oRhnZwVSSPyqTNpO/kmK1xGlw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-EI2T-wKCNHGVrnNQ05uAHg-1; Fri, 10 Oct 2025 04:55:12 -0400
X-MC-Unique: EI2T-wKCNHGVrnNQ05uAHg-1
X-Mimecast-MFC-AGG-ID: EI2T-wKCNHGVrnNQ05uAHg_1760086511
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee888281c3so2161739f8f.3
 for <dev@dpdk.org>; Fri, 10 Oct 2025 01:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760086511; x=1760691311;
 h=in-reply-to:references:user-agent:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V331zmIgYL1KlkpdkbSKzYTs4FAePlvLzhY0vafj4JI=;
 b=Zpjy0wV67dhajDS1qUSfrUWAMkGmoAm9c4iJHxjDgxTpKUNep+ZKtoGJsfr8HqjbRs
 gvrotiQr8MesEWuWh5vBSHHSlXVlok0LNsAluHR2JuS3PzhcicLAzu1XvUpc1ewcRFzB
 HVSzIqGxT4vSK1CsXCUdd8axcqojcZCfUI4papiVT0sPe9Gjc4nqucqR4+tznSE339hV
 vwtwDdo6ZaifLPTjktLOw57eHckCq2dSObjBqbBch7QYQSyp68GObSAc72OQUHI1quzM
 wz3c08D/lr3KgLOF+RsXc0sqMRVMTt6r3NqBwbkoVwvOItSJ0/2VJusiwFu6UYQLEz78
 78pg==
X-Gm-Message-State: AOJu0Yx56RElNYhMu4Q+nJlCA6L2J4oC1eGTyG15JGOnClI6eliS+374
 P4odbpA05DK3tPxfp1DvK3+AqFQrWMsocNNu9PuZNwdvANJ/dfBk0WcT246dAe9/jC+VOWB6DJg
 EwGhP2/cwyxMJVw32OnkBesTtTXRwzhxP+pfCel/7LFzrHObukQ4DCA16AC1545TTkWN9iPAKOt
 P8vBMPQmiwe1/Zp2r58ZY9E5W7EA==
X-Gm-Gg: ASbGncsS/yJdCFsZwIk6zrO+G1dSrVmSUrbwECSdyWP+54xmd6sajmwo2gfay1xol6d
 FGD8Da/EtaX5ulunW4+GsXo/qQtHsTJCVo2P0pv1ShzvwsqLk9xHucslyF75H5jbivPFrzzPx6A
 gRYZugTWUbnJQP7eVA5zKzleHDGGoNwmwzQU9ACDKfOkNyPHsPdQ5D7Z+jsHPpGoXcsGVDvYK6h
 /WMOizuHrIG7jBYWSVczgHlVHxy+eIMLu1DMFkhuqpvkTciCSxj/QIfRitJKnYRj0j8vL2fq9UA
 T14udU2QEYiY0yhbyBpPCfMLyG1OUmfNeprTc3rlVzzaVNcRgjyj6qvh3XphsEoxSXPc1Pj1L2L
 EOuI8RI38lyQDAVwqe43hRSA=
X-Received: by 2002:a05:6000:1a8f:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-42666ac7279mr6890022f8f.24.1760086511163; 
 Fri, 10 Oct 2025 01:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Lkx6cuXlzHht5S+sn1rKJuOcOdUr8fhQYhyxdPfA7BTGSNdIo18z911w0hpRETkK8Cwo0w==
X-Received: by 2002:a05:6000:1a8f:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-42666ac7279mr6890002f8f.24.1760086510676; 
 Fri, 10 Oct 2025 01:55:10 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583424sm3084537f8f.21.2025.10.10.01.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 01:55:10 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 10 Oct 2025 10:55:09 +0200
Message-Id: <DDEILG4ZSB37.Q38N053PLJ4N@redhat.com>
Subject: Re: [RFC PATCH dpdk] fib6: implement RCU rule reclamation
From: "Robin Jarry" <rjarry@redhat.com>
To: <dev@dpdk.org>, "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
User-Agent: aerc/0.21.0-9-ga57e783008e9
References: <20250610145341.38271-2-rjarry@redhat.com>
In-Reply-To: <20250610145341.38271-2-rjarry@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Xd_vCEWL3Gr5524Jt6Qdeo1XOSZqRpon9-xm9zzJXo_1760086511
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

Robin Jarry, Jun 10, 2025 at 16:53:
> Currently, for the TRIE algorithm (actually, it should be called
> DIR-24-8-8-8-8-8-8-8-8-8-8-8-8), the tbl8 group is freed even though the
> readers might be using the tbl8 group entries. The freed tbl8 group can
> be reallocated quickly. As a result, lookup may be performed
> incorrectly.
>
> To address that, RCU QSBR is integrated for safe tbl8 group reclamation.
>
> Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>
> Notes:
>     This is a semi-copy-paste of the FIB4 implementation.
>    =20
>     I couldn't understand the implementation of trie_modify with regard t=
o
>     depth_diff handling.
>    =20
>     The unit tests fail because depth_diff is always 0 when deleting a ro=
ute
>     which causes any subsequent add to fail with a -ENOSPC error.
>    =20
>     Vladimir, could you give some more insights on the matter?

Gentle bump. Hi Vladimir, could you have a look? Thanks!

--=20
Robin

> Not recommended for children.

