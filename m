Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14910CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 03:35:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 302DA40270;
	Tue, 12 Aug 2025 05:35:43 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 9D9F94026C
 for <dev@dpdk.org>; Tue, 12 Aug 2025 05:35:41 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b3226307787so4003832a12.1
 for <dev@dpdk.org>; Mon, 11 Aug 2025 20:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754969741; x=1755574541; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oUFEMKNSsDQqmNkR8bnPAXEEp2C9fE47OusENmlaEs8=;
 b=UVuHkROyiIMwbcNJsqSAYHpTL4RObLdb0q7yADwvYE7cvLw3uksqvFIXdZATA5ZXIJ
 p5vJhir7EUeODwSXsyPj2+H2WXWqvAC1eDPTWzYCQEeqrDCrckA3xyTLItZFrR52u15Q
 +EHfUS0vApwhVjsZBtOFNkG0cHgg8vuRxsFqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754969741; x=1755574541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUFEMKNSsDQqmNkR8bnPAXEEp2C9fE47OusENmlaEs8=;
 b=Ejs8Zu2Iu5lkLdnv3rJvNNzbD8fHMtcEwYU16bYZcbzEHlYRHrfBwd7By0XgKjZ3C+
 lS/tB+JazwsbeSEgk8pWFKc47BThBv0Qp0ZtNM+eFpWgZoraou2IqNYA9KnxVkSFyhC/
 Wkern8UnzP6kGYvb5q/KFyU+2+OFPmrfryrvvZKDa6YI5HdYM3KCNCX4DuGJAaJ5Kl4V
 Ls7WCqJkdtfaI94irnwd/4KyooKnKyziPHcMMrBjNqANiAOzy9qzda1rpG5BTeLsgfTm
 JCH1sY9ita/3hebpoQ+fLQeJe/81+FtnVykwuda4lDhguwgbvkFMlBlpjywiosPb3ZlP
 zECQ==
X-Gm-Message-State: AOJu0YypkCfouIhq+L60edCni8FS3oLr/0P9KNbfWvoTOx4oqZN2Hj3A
 hwQO7KnJdIVrthyvlG2jnrr6Zzb2KNKLN5RIQdakc08JM6/7wVH7YI63PEBTjvWz+GgR6K3q0Ag
 Vz1chmI/zeSQrR0VnKyNfxT4qF4YZESqfP3eMhRfs3A==
X-Gm-Gg: ASbGncu5n6eu0z9Rt1WkId9jkUw0fGCe3ZL02/3rg/fpQkVJYozDI2oXHcSghhWJlb1
 KhaQPh4evuYvx9gaKjTpSdIf13ob7OArfXtkw8t5R7WTtcZPx9lxooHNUOnrHelCXwYlwWJzXMf
 lKR1PqIWi6hPQr7jXE551b7bZq6P7a9tl9hDId0/eevDKiT1H8lsliL5HFy6ewkmf9DH7LRWDnR
 fGYSzAYAITzMk1KOS8No7s=
X-Google-Smtp-Source: AGHT+IHvn60VzDUnSKkewpDljucF+Bhq7nCoj/oUAHnX6o4znAROioRmY3Gx+FnZz37h+r4JXyBUKSmUR2P+OYLPgy8=
X-Received: by 2002:a17:902:e5cd:b0:242:9bbc:3646 with SMTP id
 d9443c01a7336-242c225abdamr230328205ad.56.1754969740652; Mon, 11 Aug 2025
 20:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-7-luca.vizzarro@arm.com>
In-Reply-To: <20250725151503.87374-7-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 11 Aug 2025 23:29:20 -0400
X-Gm-Features: Ac12FXxffQ0GTyKehtceXk5COjwIjDO7SCuy58GVAEP_k370puEVbUFbTDRU1Tc
Message-ID: <CAJvnSUBPvZQ-Sf=Q+V3AmpxB2rGDrUVO2Htp_xTVj0=ZwntESw@mail.gmail.com>
Subject: Re: [PATCH 6/6] dts: use artifacts in packet capture and softnic
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000fbcace063c22bb87"
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

--000000000000fbcace063c22bb87
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000fbcace063c22bb87
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--000000000000fbcace063c22bb87--
