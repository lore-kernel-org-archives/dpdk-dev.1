Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A459D277C1
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 17:21:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA3BB4028E;
	Sat, 10 Jan 2026 18:21:38 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 30BF240144
 for <dev@dpdk.org>; Sat, 10 Jan 2026 18:21:38 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so28658295e9.0
 for <dev@dpdk.org>; Sat, 10 Jan 2026 09:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768065698;
 x=1768670498; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Rx9/4wriuhJZRK4l1Gy/quMnTcsZlxVGF/0cviX3Jo=;
 b=eDKvpJREqxUpQIKd2odOQ74rnfB+hxuVUEydU2vjBntxfdL7ybqpZBBuJRTZfkkQge
 A1zNxiq2ABaAIERZd1lL0AiUKpkR8XrxBXMdv8A/dAsDPE/CTwa3tI7JuUY3AyReG0F5
 syiW9+76lL/0fpqH93sMIvLAWqaKKyKN+VWB6/Gr/5Qz49i+QrhQlY+FhGtk6QF3kDye
 B3B1zf3P47j+HtMifokta93vQk8JwlK81ibZ1aMyBSV0azntodVj84amDWgLbXYqAV88
 EwptbF5YCuTxFXXT0jj58W0X3q18l5wGCSzoFSW3CSC8mxAs6AwUVnDmW/VsS4ZUNrZM
 C/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768065698; x=1768670498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Rx9/4wriuhJZRK4l1Gy/quMnTcsZlxVGF/0cviX3Jo=;
 b=siLsAXarThfulpaIZbss/MqDqaKdmVbWdGZqZ9NE+L+d6YHckSDACGqfRS2S3fiZFZ
 g1uEB7B1l/KkFjDzI0wgVD37FxVm6rCCkeuaovjwx7wpYr6V+V/GaNBeuolHtEXt0Ltc
 vDu359H/XJbtTrgaOSqNeHQdnIPTKbPyWi/itg5O6hOlic4+3Iabb0DuUNl5+/BVq/q3
 6IB62PfDNlUynGsWGY2aNxndzmR02jZb9jzZ0JcNzh2wFNGV4sJlax7brdiMBU+v4/cS
 8s1iIkBy8Xcn4tLkziuyE2ZXJ6qDuX/MPmqGTxjrV217/4Xek44L4175w0H3PpoVUX3C
 +I4A==
X-Gm-Message-State: AOJu0YyiWMx6TgOrBz5XnLPRcUDMROvnU3Fo/25gCWiBgKXLbS6bvOJE
 Z+zTzZLzG4Ty9NGeH9UqmWcf2FTqKBiz8QHQvV8601zO0ht81nyF3wo0YhQiZgyCgd0=
X-Gm-Gg: AY/fxX756epZcNgVkHZWuFf3BbEWLbB+0u7ZXaCeGFJwj3UPqonXnzcBf65cZtvbKeC
 2ONYgQrVwEosMQ9xkBIfRDDbyVGLkLchIcyNrGOft7rteqa3t/jfN9rb8d56kJfTIYVluhCFp1E
 eEUDLfVRbOQzUpp1azGHFxw74jPVFGRc0kyq/IASUSGQYROScGuZs6InsElyEqGz9LruFnnUYj+
 8cT3CL/Ro3hv1weQ74IMTWNcRzhTx/K1V35Y2F9om8t2jTPmKiTK/ynkzEBjJHmLCJeFEvQtQlz
 Y2CXiWkjXa2JBv0fEQ97dWJutzUl3vOexOMjKuoVIBNKkQJXhhTFRsrP632iC97odgBKZB8oTGW
 AFLFw5ioFeQuyZIoQBhf329X1RD2VKM3M4moKq1byExyvs+YMW1cqSdoxJV+WqIhZI8kae8aC+N
 EohpwRADHGWuUpEO+FDO/xzE6QYHd5K2r2ekuvrV1FgVinDYlAHUC2n/JDLWTC18A=
X-Google-Smtp-Source: AGHT+IHGO99kO0zGCOhvoCylkXyOB3yu/1DEp1Sd2+3PXbl8QJoBc75rHRb0UYY6dekLtHKQiEYk9w==
X-Received: by 2002:a05:600c:3b28:b0:477:8a2a:123e with SMTP id
 5b1f17b1804b1-47d84b41bbfmr151613005e9.33.1768065697439; 
 Sat, 10 Jan 2026 09:21:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df939sm28409288f8f.21.2026.01.10.09.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 09:21:37 -0800 (PST)
Date: Sat, 10 Jan 2026 09:21:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v3 2/3] test: allow larger packet sizes
Message-ID: <20260110092132.729f93b8@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6563A@smartserver.smartshare.dk>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260108204449.176087-1-stephen@networkplumber.org>
 <20260108204449.176087-3-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F6563A@smartserver.smartshare.dk>
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

On Fri, 9 Jan 2026 16:00:00 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> >  generate_packet_burst(struct rte_mempool *mp, struct rte_mbuf
> > **pkts_burst,
> >  		struct rte_ether_hdr *eth_hdr, uint8_t vlan_enabled,
> >  		void *ip_hdr, uint8_t ipv4, struct rte_udp_hdr *udp_hdr,
> > -		int nb_pkt_per_burst, uint8_t pkt_len, uint8_t
> > nb_pkt_segs);
> > +		int nb_pkt_per_burst, uint16_t pkt_len, uint8_t
> > nb_pkt_segs); =20
>=20
> The pkt_len field in rte_mbuf is uint32_t.
> You could upgrade the packet length here to uint32_t too, instead of upgr=
ading to only uint16_t.

This code is generating UDP packets, and the maximum size allowed with UDP =
is UINT16_MAX.
IP packet length is also limited to 16 bits.

But you comment did motivate fixing to allow more packet segments.
