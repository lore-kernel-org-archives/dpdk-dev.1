Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0405FD45F9
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 23:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3DDF4021F;
	Thu, 26 Feb 2026 00:09:11 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 99CD2400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 00:09:10 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso204259eec.1
 for <dev@dpdk.org>; Wed, 25 Feb 2026 15:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772060950;
 x=1772665750; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUAG/YY5dQZhT6Xt/GLpRyE+8o+AvbRzrhsqO5eEgsE=;
 b=Moi9/xLTijkxloEIeWymeAPBku2EmnzRmqvAq4rlYs8DT+J96M9rcTX8ljBvfyiUPp
 pociuPPWsyUoV9ywru9ltLx1FN1ppYMkeq7CnpiBYjRJvnUMj/SWWbb8th/3Eiml88T9
 bythioY+lgnGQ4sb472cIHJZqb34b/uGZiMu03c5he7oOxzWCaGr6hHUmq6yHAWmTihY
 6lJxKBZy3xL17upx8R0jsedMA/jfmrozlR58xEQ1lUTZb85xEF0fVNI3c0iRdIKLPF0j
 CVNlCBw9ykUSZVuydJtq2KXmPPGabFzuFrmav6YR/ZIVTdesCCK7TdMz0sGMlVnyVKq4
 V82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772060950; x=1772665750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JUAG/YY5dQZhT6Xt/GLpRyE+8o+AvbRzrhsqO5eEgsE=;
 b=Gwk7PXAzUMmoAEF50vakckAjBLRr4FBsBfyO+jJlSCRsU/g9VTH5cW+40ZHJmCRpt9
 2aKN+XV3atNAHGlJT+j3x9/RmGoGoTuoZG9qkoXzI8W8F4VY8nGJAPyLRQpvjDS7ull6
 RTnGpB13G5Z2pnGBk4brJBpQs5dYraDAARIX5pufNP13VWfRgeBe9y9wmZx1QKguoC1k
 IGhNA+S+yXp7mS7dt6484ZHCsXN9AfK+YiAFioaK3xiW92zFVaCYqny6Qd0EFXVMD26Y
 GLfWYCMW5OheYw0WSFwTeESCvwvhFCkLvD+OxWGHvMOMQt9qiOrqK9x1kxs8guqchVAG
 Bebw==
X-Gm-Message-State: AOJu0YxrdRInKsLwrbZYEEsSupjxh5/zmgq58e0nTpvuuFd8v/01colg
 5q0ij9pQ3Qg+zXrrZdz5cJ7XF8azHVSjPjJlxvKqyiFP5KtLGNljgoPpFYDh50KgKCs=
X-Gm-Gg: ATEYQzwFgbLiKUoVEVwQh0XZKbD7keehKSTXQgZWK9b2v6TKPOFCm94lq1IO+1tbwSe
 m1GLeRIKcmHjv4TwEKc67Ycr9csiMzTsaMschkDi/EmFKRkys635EUTxhYVG7WCpu6su99A5Qt8
 vnAEFP4v8u2xjNLlTJqDL8WgsNToYgexTW8OOpuxd2PaJPBisOujXVIcXJ5EYch7D/NySVTF1s1
 g73aKZadWzEdu24WKn/reBVC8dPIM8wRlHfaQZBMhmxkrlDZYkZBGedrYM5CjAziZ9fEidneirW
 ohoUUS0RuqTORvwA++HlUMaWSyl8TehlRbUwgxVd2kWIXqwkbxU6SCDjEReqVN02gVOPOPImoU+
 5Q5V7z6FTMTRhvBcHJ5t0TYjno3YXH9kU49BCXuWwNwRnX/f1PaZaapoM6VzOhUwluFx6cqwnm9
 THg+W44FSvrDigb6ytbwF2THUkX4m87v/ZEMzKbPeHD3005PnnuWeUlXPLxr6DlUih
X-Received: by 2002:a05:7300:5727:b0:2ba:8018:cc57 with SMTP id
 5a478bee46e88-2bdcbf66996mr985496eec.11.1772060949501; 
 Wed, 25 Feb 2026 15:09:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f23c01sm382509eec.16.2026.02.25.15.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 15:09:09 -0800 (PST)
Date: Wed, 25 Feb 2026 15:09:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH v2 1/3] net/axgbe: add external PHY read/write functions
Message-ID: <20260225150907.54d467ef@phoenix.local>
In-Reply-To: <20260225124456.1871-1-ashokkumar.natarajan@amd.com>
References: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
 <20260225124456.1871-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 25 Feb 2026 18:14:54 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> Introduce helper functions to perform external PHY register read and
> write operations. These helpers currently support only IEEE Clause 22
> PHY access, providing a simple and consistent API for accessing
> standard 16=E2=80=91bit MII registers on external PHY devices.
>=20
> Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
> ---

I didn't see anything here, but AI spotted some things.
Please revise and resubmit.

Thanks for the series. A few findings, mostly in patch 2:
Patch 2 (M88E1512 support):

1. axgbe_phy_link_status() always returns 0 (link up) even when the
M88E1512 reports link down or the read fails. The goto out path leads
to return 0, which means "link up" in this function's contract. The
link-down and error paths need to return a non-zero value.=20

2. Integer shift UB in axgbe_get_phy_id(): (u32)(phy_id_1 << 16) evaluates =
the
shift at int width before widening. If bit 15 of phy_id_1 is set,
shifting into the sign bit is undefined behavior. Move the cast before
the shift: (u32)phy_id_1 << 16.=20

3. axgbe_get_ext_phy_link_status() doesn't
set *linkup =3D false on the BMCR_ANRESTART early-return path. Works
today because the caller pre-initializes the variable, but the function
should be self-contained.

4. The new out label unconditionally clears
rx_adapt_done on the M88E1512 link-down path =E2=80=94 please verify this is
intentional and doesn't interfere with the internal SerDes receiver
adaptation state machine.

Patch 3 (100Mbps):

5. The SPEED_1000 =E2=86=92 SPEED_100 change in axgbe_sgmii_100_mode() is a=
 bug fix in existing code =E2=80=94 the 100M mode function was incorrectly =
configuring the MAC for 1G. This should have its own Fixes: tag and Cc: sta=
ble@dpdk.org so it gets backported to stable branches.

Item 1 is the most critical =E2=80=94 it inverts link status reporting for =
the M88E1512.
