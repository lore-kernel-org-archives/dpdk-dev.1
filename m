Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4976E6689C
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 22:02:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFF274027A;
	Fri, 19 Dec 2025 23:02:49 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id EB30E40276
 for <dev@dpdk.org>; Fri, 19 Dec 2025 23:02:48 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-11b6bc976d6so4880947c88.0
 for <dev@dpdk.org>; Fri, 19 Dec 2025 14:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1766181767; x=1766786567; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KlJVPDyvcmoQhlf35bdp93QIr5lOgvPowEAiECkslBY=;
 b=RzQsS8aiZULZQ+/cRgm95os1x/WC9xriXPrsvp9lO5nLOnEhpvJEBH5+iOHEVruflP
 rSgikygUy5Y1kH7W+JyCpEnqQnokDin5VD1wloBXWG0rs5INagNayHTnWDGsVpI2oHxN
 WX6wgnCrOFgYZ+ZrDiWcq1MNPjGRQX+0ESFIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766181767; x=1766786567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlJVPDyvcmoQhlf35bdp93QIr5lOgvPowEAiECkslBY=;
 b=Qgcgoo9QpegoiRKXJJ+Qpe2TQGjKqZNzNL0goaxqkkyacyehZcEqpPVPEsg3Rkyu4B
 45J+BhdKIQpB8HRaEXo4jfLt5v5jER4UFRWvUTz/TS0DRZivM6kNguF31CJG9h1qIbui
 u0Yj1LAcWI3HF7d2Rhz3Af86zx364+Nyje6qDKPzY0w1IQTTTB8WTKauLlQTDAM+SwBL
 gHpCafrRVpVhhPb2lqjfHXLI+oBcvLGO5bZwtVBP3LoVYRSAlrx5FH8WuYgIyKdpQ5yu
 XJYbQlc4LOOelczWgW/XdN+BlMV14CJ3Y+ZrfjTAlwRl35v4/erH969WpwUdpm5QBzIY
 Qq3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRJt2tZXHgZrjlUVBGYGhDqmTJWSSXI8DU6xC7B5HvdAVsGMOY54umsW2rDRYEcwFCE8Y=@dpdk.org
X-Gm-Message-State: AOJu0YzeDXeT549l7dKtm+aydBX+HcDd6lWUBl+ubHqb5Dz7BgvSZZqa
 iyjSuQv0AW5169nkcMdylDV1Ix/TKLXe1bA3yk62U4vOmqagBP/N14g7vZWh0rEkX8xYJBOtGVf
 ue1ltm4vz4+666rRDQEMOLHCkIV561X6jQMG1Cg74Fg==
X-Gm-Gg: AY/fxX7et/SuRRa9dI2zcW3xjQ3z6pP2kAyc2wVY1a+/v1gffqM2DgX1dkOkFJ6FNiJ
 liZKkdwjf1Z5Aeb04FXWn/ZC7vHq/rnsfUOMomDe+iWmnGTcpIHQp4sQnzjWOQt/OShOkDEAIEK
 SIdIyDqyCftI+zeDW+Xm8xvkDJ0Cmpa7595BYlMiQVP4Wpd1UuQl/0JXaCvblw38av/hARBODTX
 chOrPmR0XQTE1SJQAwJnuAGKO42ahuLZB0wgBGXJUclMDoSwn6yikl/qLUvALlnI09yJfAMhrzE
 mFuY+hD3CA==
X-Google-Smtp-Source: AGHT+IHdVb2qgyqyTWktQElEMkTH6RdWt0WJz5FQg+914Xzne3Ijur8jHZSlqk2T0pAFTMTog9VnuBk/XiRVVC58++U=
X-Received: by 2002:a05:7022:670d:b0:119:e569:f84d with SMTP id
 a92af1059eb24-120619279c2mr7881696c88.4.1766181767299; Fri, 19 Dec 2025
 14:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20251212110944.59350-1-madhukar.mythri@gmail.com>
In-Reply-To: <20251212110944.59350-1-madhukar.mythri@gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 19 Dec 2025 17:00:56 -0500
X-Gm-Features: AQt7F2qxjJnP6RdpoPHe7bPr0u6cXY6XKcO7kAi_QwonXiazZ3yZxNQZWS4O61s
Message-ID: <CAJvnSUDa=vcR+bm5wZJcUm_vKgW6zPqpj9fXruu5P6HrX4NwbA@mail.gmail.com>
Subject: Re: [PATCH] net/netvsc: Fix on race condition of multiple commands
To: Madhuker Mythri <madhukar.mythri@gmail.com>
Cc: longli@microsoft.com, dev@dpdk.org, stephen@networkplumber.org, 
 madhuker.mythri@oracle.com
Content-Type: multipart/alternative; boundary="000000000000d958ab0646553cfc"
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

--000000000000d958ab0646553cfc
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

I am putting in a CI retest - no action is needed on your end.

--000000000000d958ab0646553cfc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance<div><br></div>=
<div>I am putting in a CI retest - no action is needed on your end.</div></=
div>

--000000000000d958ab0646553cfc--
