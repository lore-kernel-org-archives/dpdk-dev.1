Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF839E6689C
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 22:01:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C320F4027A;
	Fri, 19 Dec 2025 23:01:32 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 1A6CD40276
 for <dev@dpdk.org>; Fri, 19 Dec 2025 23:01:32 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-34b75fba315so2537288a91.3
 for <dev@dpdk.org>; Fri, 19 Dec 2025 14:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1766181691; x=1766786491; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=92r/jQoImjooPg/bFLZmgEBGLQqABZ8hNIa7CnLbUOk=;
 b=Nfbz7FZPOl50AWK0eY7yaiSkb7JDRxxyEXPaRrQenfFi5sF2VT65kpbf687nmWz6YK
 JBg/7zhry8HDBJ2rs6eDtDRtvgocvU1ZEOxs2Ls8W99iE13unWVMAzQZepaFXAO/eJbq
 /ERtB1FrJpHf08ftz6CaA8sYovVqQDUZA4DCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766181691; x=1766786491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92r/jQoImjooPg/bFLZmgEBGLQqABZ8hNIa7CnLbUOk=;
 b=BEuzs70lzdGkJOLdIme3hAHV+6xwX8LFhjI+i9IzlOGiT1YEuuH1eNDsWo3ao4aCus
 u/fop2SWxLz5n4P+P09JqyQ6oX+I77wAWBfAC/BbaObO+7wJdo0T2TvSvSozd4oQ2UTC
 N7RAMsgidPPuWNZX/VCo05k6XHMRCQgsTgtRE+Uc9iXc20Hv00VduWzKIOqkJ2iXL9MS
 LalnwF0Sr3yPxh3Qh/ZFOr6/8MHEQuWqmbgew5zhGVypQk6sgQBJsok8VuRcFreu0crM
 f1S23xSQvrk7loVrlPw/ZtwuEt0g+RboNCnR7hbTJ6W1HvDC4nx+gDo0n8mGZtLtAAHu
 D13w==
X-Gm-Message-State: AOJu0YyHl1z4QRIyH1A3jZYsOaJeqgUBYj5Dh46tGbElYbjeFlQHTk6Z
 nEu+81UpwYs8PqC7Mo9qIFKdMq9v21Dp45MVprkVV4QgXb48syDRhj8oJ3DozLAjUK1YxrztEDz
 1OVtDhNWqOhKj+T6kgxqrjKpxHxqtxeW1iXfuSt2Ovw==
X-Gm-Gg: AY/fxX4WyJ1yBIqxTQ55C/JBfUVf/XbAoYJxdtwZt87NrDmwYmAtDauPrRcXXsIvjrK
 9mMY4rdNseRpPanYjDRYjk49ZrMBWjwU34PgUFxYjjW89rA6inOg2Wi2AFyDkB+urwjDWG7CGlB
 CzWriCo6nUOaBNqWznyJFGxdAa0GsWsJQHf8HLr15jp08UVT03Eh/V5VDafuJXebGJjp3SYUGpJ
 7oZW0ZT7N7k/7fwmCFUFyI8Kf+Fax7SvyBg9hV9nw7trmoJ+Z195aZ4BpoQymN4I2v5xI19p7qp
 Va38RNI99Q==
X-Google-Smtp-Source: AGHT+IHI/0KcY5B+ccxosLwrom1/DQTa7QUPdW9FviLYohfWUn2QTr1XPwDyvt3HoroOBkcK3IdbkfaY0YvtsOuhQok=
X-Received: by 2002:a05:7022:3f06:b0:11d:f44c:afc6 with SMTP id
 a92af1059eb24-121722b842amr4068886c88.15.1766181691008; Fri, 19 Dec 2025
 14:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251217201143.155053-1-anurag.mandal@intel.com>
In-Reply-To: <20251217201143.155053-1-anurag.mandal@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 19 Dec 2025 16:59:39 -0500
X-Gm-Features: AQt7F2qZX9qD0SD0_hqW7FR2GAFEjIUWNlzB-GfuHijw359sSu-Zju6vTyV-bcA
Message-ID: <CAJvnSUBcjA_fcFHoSLqsewqafY_CDcMhwR2y0eTPrry-jh2GHA@mail.gmail.com>
Subject: Re: [PATCH v4] net/ice: add MAC anti-spoof option
To: Anurag Mandal <anurag.mandal@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 mb@smartsharesystems.com
Content-Type: multipart/alternative; boundary="0000000000004d354506465538cb"
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

--0000000000004d354506465538cb
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

--0000000000004d354506465538cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance</div>

--0000000000004d354506465538cb--
