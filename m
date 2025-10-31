Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F018CCF9FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 14:08:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28F4940609;
	Fri, 31 Oct 2025 15:08:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0B09440150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 15:08:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761919698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjJLRJz6P1nYyMroH9CWgLUtZh8g9wM/Tfv/vsE+5Nw=;
 b=bAG4ccEJJqDYWCB+aSAJwbCEZ3tq9zAe4anZpaL5dyPxmL3zwvZzP0CvavVo6z9Qe1OQFL
 irR7W4kPHcZsLHq4MRt3EaXFHwyRerdS+9VnHUF3BfBjvWGUrUAgQ/APsHIpuTgmIvgxrZ
 K02Vqm66Ec9/kgtL0MQRjHY5LW0Dj1Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-I7-yQzg_OKuJ8dKOKXYAow-1; Fri, 31 Oct 2025 10:08:15 -0400
X-MC-Unique: I7-yQzg_OKuJ8dKOKXYAow-1
X-Mimecast-MFC-AGG-ID: I7-yQzg_OKuJ8dKOKXYAow_1761919694
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-592f0214ee8so2966266e87.1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 07:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919694; x=1762524494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjJLRJz6P1nYyMroH9CWgLUtZh8g9wM/Tfv/vsE+5Nw=;
 b=GiNAJtMXRelGTCyXhQYQiwdhkuUB2vqOw0Mdna3myWsKOHI4d4u/EehHD1JWgfkNz9
 ggtP+CQG4gP1J1YYo47ZozDC9T9fVoRNo2UuhChkfVTArIiRC5zR0xfPaGWrqe8Zjiin
 KUzv6iadQV4o0xJXRbJG9D9KulaPAeCBJmD7j8EGTfKcfudC5BXFDY2/g1sJqn830sMu
 kicJm2JYGtcdlnw21sXyA0Xus+MAzcIuQzYJ9HFzjrg3qfPPMIYBjw7tZNr8lAfx4hhb
 4zCWE3QPUdRIMHuRKzsE/49fiXhxFO/fQ4AfkqtB7soXglyQ3gB1kxeMfoHkDWuc5BwS
 G8bA==
X-Gm-Message-State: AOJu0Ywjcr1UOAZatjd8XBTRaodcFpun0Akc0I+pasGb7Tqu5YkxpY9P
 wecZhkTicchkTBtKf7kzRJk0VPM9l0267tR5k7TM8kErDx1la2g+fXIGURKzbI9SXlcf2sDzxrz
 ZDepw4Wl8hMIknTtRSnH4g7yxYBj8KLHkstXyN1/wN+MXpDygjS/76QPGpyUv+lu/LAtIIFtHk+
 8ZxPtkWkylrmL6x1EE5gychjDflNk=
X-Gm-Gg: ASbGncvkUeQZHKgj6hDvcIskRqHkGVhEMZPkaS0UQAe13wPtIji9bJBS4s0R1cT3CfH
 IGhp8u0sHhvGfi9qfHP447hZeKREfxcYyQ7MGTQH1XoLIZk0432QVEu5fl661sVTYoBghWlEx/e
 pb8dWmmyeJGM+Y/O0F8EUX0mhknFjJ7hPcB6OG3h58S58Muv2hFkE5usGvtg==
X-Received: by 2002:a05:6512:3b11:b0:592:f6ea:24fe with SMTP id
 2adb3069b0e04-5941d563d06mr1334968e87.40.1761919693916; 
 Fri, 31 Oct 2025 07:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBMgZJ/+mED+/tqvzmJc0Ap0HLFajT8ioKT+Emrms27rNKBXcrOEXdxb/akISe58Tuw+7fLClqFpDrjvZCqS0=
X-Received: by 2002:a05:6512:3b11:b0:592:f6ea:24fe with SMTP id
 2adb3069b0e04-5941d563d06mr1334951e87.40.1761919693311; Fri, 31 Oct 2025
 07:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251031131159.1199221-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65523@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65523@smartserver.smartshare.dk>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Oct 2025 15:07:59 +0100
X-Gm-Features: AWmQ_bkT8ykpnnVpdXZrmNJxKDEM8z8x41clel7Q708HdDHBHE_kau1QvsoTZzQ
Message-ID: <CAJFAV8xfDUuAt_aC0rzi6pJ+7YXWfEBejx3MJB6Szi28+bZU5g@mail.gmail.com>
Subject: Re: [PATCH] mbuf: dump Tx offload metadata
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oscIzSlN05c-uphSYk0KA4MA3H4EW4ABdFEw8ZcNo_o_1761919694
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

On Fri, 31 Oct 2025 at 14:28, Morten Br=C3=B8rup <mb@smartsharesystems.com>=
 wrote:
> Printing of outer_l2_len and outer_l3_len could be omitted if not present=
, like the VLAN IDs, e.g.:
>
> fprintf(f, "  ");
> if (m->outer_l2_len !=3D 0)
>         fprintf(f, "outer_l2_len=3D%u, ", m->outer_l2_len);
> if (m->outer_l3_len !=3D 0)
>         fprintf(f, "outer_l3_len=3D%u, ", m->outer_l3_len);
> fprintf(f, "l2_len=3D%u, l3_len=3D%u, l4_len=3D%u, tso_segsz=3D%u\n",
>         m->l2_len, m->l3_len, m->l4_len, m->tso_segsz);

Mm, why specifically those two only?
If the intention is to make this debug output shorter, I would apply
the same to all those fields, and omit the whole (new) line if no
field is set.


--=20
David Marchand

