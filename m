Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D1FC43327
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 11:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8712140299;
	Mon, 29 Jun 2026 13:05:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E0BA04021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 13:05:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782731136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z8nPV1fGqeD77lnHOeO4rWFdnnSEx42MhIiBQyj1LjY=;
 b=MDrLTgk8rUte0gBy9wodk6aX5ns865FSO4kT2EF4/6/bMHp2trTa1FrrWG2SEAncz++wPU
 5ZAT/cs5aHV0QVuSvp+OXX8QacgYeXWhWo4YBBnVW7mvyhzJt18pjI4UrlPS+zVpx+f3tk
 ImIbuFvUw7uKATbdLozukth5WF/D42s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-dZmVDpo2O4Cl6hieQtbUrg-1; Mon, 29 Jun 2026 07:05:34 -0400
X-MC-Unique: dZmVDpo2O4Cl6hieQtbUrg-1
X-Mimecast-MFC-AGG-ID: dZmVDpo2O4Cl6hieQtbUrg_1782731133
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39af889f409so5489191fa.1
 for <dev@dpdk.org>; Mon, 29 Jun 2026 04:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782731133; x=1783335933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8nPV1fGqeD77lnHOeO4rWFdnnSEx42MhIiBQyj1LjY=;
 b=hIqkW5vX0wOtHHFyrFJoDAGEqVzSzDG10shc68ZyHDfIbTSkQHQPf1Pckm+QeNFEUQ
 OhF/fFjImUusEY4FCaZql4OVf99OcAh+cw0AXxSIPXGyARtiollm+1L7TV/4owmIGsSi
 ZyOWUd9g0PdTKI1SnbDkd/PTBhtK8Rlk8FDR2NEA/YHZR6vqt6Nq5R4puSMf84HJJuVq
 xkIXzq4tsQMr12IEvrvRqSBi/U42Wm+aDksTx8glshN5AOWY8LGJTThN+/eTqfyUZVEk
 7CgQKzqYXLecLdmw2AsgFdrTfFkQ+fg3lcWyFSy7ArP77GWJV3K9ZUXG5kb9VlfxuJaW
 7HBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqR4WFuwKLiQoxWIGFrdbKxY/O7pCx+EG57d95MzDsNyGNTDgXxMqOiVEy3E6cEsGWSpbc=@dpdk.org
X-Gm-Message-State: AOJu0Yxnc574wwCls52Gh69Yeqx7wHE/BLe1QLun6UBcUH//KewAAynK
 B3an3apcDPZ5znQKTk9wB3WhzcCTWXAwPksrVtNP6l9kkqzCCvoIZ7HLFprvXSKx8rrU8fXecaj
 NzjU8nYt4pG7muXvUZ96ra8eVVnpkZaHR2dC9+fx47qNp5/ZgfSFkAROXC2Jfo8l70WWrYpQyG8
 LKkJMUUkqfKWgrs8uT2xs=
X-Gm-Gg: AfdE7cmJqAtOnkbeivNAq6SlqDLadVNOOgWylDmW/0nDHmT4jN6/W4pMQQ+dzV5ePnZ
 vVi8tCBbHJk1J0AwT3TCKI2VI8ApCKy6BSN2jCQWt7w35gl2r+n4dfNiG7Ck4gjerKF4Gbaos6v
 UsgV1yltOA1jlfL6jdBYPuoWLj0GB496XtPuXSj880omwCxbfwqIBFubCM29p+K9nH38dhpgRma
 G8+4o0tg8CL2j4kqtjhSwubAA/v8sA+zxrlDrFMQhT2xln/EqiPa6u7oRI=
X-Received: by 2002:a2e:a58d:0:b0:399:9436:15c8 with SMTP id
 38308e7fff4ca-39acb55274fmr39375801fa.2.1782731133291; 
 Mon, 29 Jun 2026 04:05:33 -0700 (PDT)
X-Received: by 2002:a2e:a58d:0:b0:399:9436:15c8 with SMTP id
 38308e7fff4ca-39acb55274fmr39375701fa.2.1782731132808; Mon, 29 Jun 2026
 04:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260609040513.919215-1-syalavarthi@marvell.com>
In-Reply-To: <20260609040513.919215-1-syalavarthi@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Jun 2026 13:05:20 +0200
X-Gm-Features: AVVi8CfK9wsvfEWgqiww2hxxhGCdXrUyag0ZLR4XbKjEZHvM98pQP5poyDZDcDg
Message-ID: <CAJFAV8wXxi-rff3FTpw4QsMXzZkuUCMb5-Ae1=JYOcoX11v9Ug@mail.gmail.com>
Subject: Re: [PATCH 1/1] mldev: fix typos in code documentation
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, dev@dpdk.org, sshankarnara@marvell.com, 
 ptakkar@marvell.com, aprabhu@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bGI6BBnptkBF__GPijtbm4dkdDLhzyaSIQgc3sU582A_1782731133
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 9 Jun 2026 at 06:05, Srikanth Yalavarthi
<syalavarthi@marvell.com> wrote:
>
> Fix typos in MLDEV spec and code documentation.
>
> Fixes: d82cac584f84 ("mldev: introduce machine learning device API")
>
> Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>

Applied, thanks.


-- 
David Marchand

