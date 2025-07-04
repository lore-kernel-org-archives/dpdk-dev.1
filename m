Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE200C83030
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 03:28:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F33854028B;
	Fri,  4 Jul 2025 05:28:41 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 1ABE54027D
 for <dev@dpdk.org>; Fri,  4 Jul 2025 05:28:41 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so349634a12.2
 for <dev@dpdk.org>; Thu, 03 Jul 2025 20:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751599720; x=1752204520; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nwx2g7AByfRYbsBHTMefH20W5OBpnzItPnnKGQ+/T2w=;
 b=DcadlWiqGH/zJAwYhMjNvwAEAcnaAUrh8SIBc5jwV1Wk/cZF4e70YPP5LNebjd9xC+
 BozhVjEu9Q94KZTpI1nQN8joGTHqNZpLTLZa+veOtVbw9n3liCa7YWHYCW+SoXo5pP/z
 Id8BF13nxjjHlqP7JrZLL0XPa0STTY7zeGt4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751599720; x=1752204520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nwx2g7AByfRYbsBHTMefH20W5OBpnzItPnnKGQ+/T2w=;
 b=VGhLPYSo8D3/uwuRW5dHfh9EJuzO6WD7Fng3jkza7kPiG6yIgb5aQ9sO4GDByGLzIH
 AMdHQ5R4rTw6aFdupeKqdfFrM9rgJiiTs4GVTtydCL/Dqch9P4Zzu9RDIIC6E/6AwkDY
 IIh1lYdF2Eogw36S1qH5sRxFqk/eed0g6d7MyKnDucf2cdvDN64Qt0EoBnwpYxWf9IRo
 DiekQ14k9l83P4rKJ0mWxFuRiB3BwEZm04jHhAn0CtWo2L4roH4Gh2Dm1AaRcMeUCyR+
 jt12QnHnyFjnWQAKsCEnfz3SN+FB6Ywz50Q/JN2ci0Bz4kGg+x+H95F+7AGf6yn/AWBz
 gBog==
X-Gm-Message-State: AOJu0YwRbi3OHNVRzRwZ9yBSy1UZ7VXkqOXwcftpxEywWvvhIpLv4Szb
 uznisHeW6LhH+fBu7c9bSzJZJespTDQE6AUd5W71dvazpCEWpZelxk5MTQa/lY4N2zlHCniF6/7
 m8Ei/+yFJHNBLpyuyNVrX+p9+4Kin4Co69PH4FHV6ME/XJvKYlere
X-Gm-Gg: ASbGncvTjgbBo0lKcKmVgqK2iVDLbqfWszgfspdZkl/GSeN4WCSQs6IvFngtWwRslQL
 JG6zbeWzS4tNvH7ZMApvEoCdlGw1ozj1cFNobOfHl4YxLMuvJp9wu9GgOlxETIL7K7oLe4W86//
 RQeIwjEx6ixs9iZmR/Pci8GfkXpGsH/EGg2gh1nqW5MmCCJeVofbVaWuPn1jI=
X-Google-Smtp-Source: AGHT+IHkWf7wq+zft1jvscZVABYBU7OQ9jvuhakWu6y1WyU2U6GuKk3daZ4e4cKeJF3CiDLhe3IiAq2Rb1PebtP0nBk=
X-Received: by 2002:a17:90b:350b:b0:311:a54d:8492 with SMTP id
 98e67ed59e1d1-31aac439672mr1392314a91.6.1751599720100; Thu, 03 Jul 2025
 20:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
 <20250702164204.607685-3-luca.vizzarro@arm.com>
In-Reply-To: <20250702164204.607685-3-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 3 Jul 2025 23:23:02 -0400
X-Gm-Features: Ac12FXzUcXKDZx1RppECqaSR_tKS6MX51npvEEiRCYSg982jyga3XtjxO2i8PfI
Message-ID: <CAJvnSUDE+84Z_Ut4rFAL1UuL59FYTaioLQmBUD=ZfpkV33JhMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: add generic blocking app class
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="0000000000001b125206391217cd"
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

--0000000000001b125206391217cd
Content-Type: text/plain; charset="UTF-8"

LGTM, thanks.

As it relates to the TREX patch, yes I will try to refactor towards using
this to handle the TREX foreground server process. I guess the one change I
would need to make is changing the default InteractiveShell timeout from 5
seconds to a larger number (like 20) since TREX can take a long time to
start up and produce the "end_token." That could be a part of my patch
though, not this patch.

Thanks.

--0000000000001b125206391217cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">LGTM, thanks.=C2=A0<div><br></div><div>As it relates to th=
e TREX patch, yes I will try to refactor towards using this to handle the T=
REX foreground server process. I guess the one change I would need to make =
is changing the default InteractiveShell timeout from 5 seconds to a larger=
 number (like 20) since TREX can take a long time to start up and produce t=
he &quot;end_token.&quot; That could be a part of my patch though, not this=
 patch.</div><div><br></div><div>Thanks.</div></div>

--0000000000001b125206391217cd--
