Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3029CCD19F
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 00:13:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A7FB402D2;
	Tue, 21 Oct 2025 02:13:57 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id AAD19402BC
 for <dev@dpdk.org>; Tue, 21 Oct 2025 02:13:55 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7a23208a0c2so1842785b3a.0
 for <dev@dpdk.org>; Mon, 20 Oct 2025 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761005635;
 x=1761610435; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Qdq6jhocXEViSnMjDgF26ZlqRXrFs1DwtOPxEQXhCM=;
 b=pjZ1/iAaA0nxfrJBCDG4b1CdcemHRrDDkcIpyzVONwFAGC9QIv4BpfPlgRMuvn+kFh
 bta/XwlSINeclfns3rGLr6q/2Z2ZRcYpVjpLCLVk0S0F63+5M2/KzjXio6CMIp7zwpOn
 os76LsWAxJeg9/r8KBnvBaG8QJ1unGeSz+k7MVRyDQn6Ax5bbJbc6t+voG3VIRGq27tp
 ScJ7TtRuQAQJccmKrUl4+SVi5TsEYcnxs9boZFEQusrzQ7M6HpWAMvgkG2YEAR2dxwIo
 D0KJ5YFqxuxR6bihoqK3nT7sH54amVGYgGixVBXy+rXogXM5ct8wKlK5sO5+RBo8QHjq
 hWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761005635; x=1761610435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Qdq6jhocXEViSnMjDgF26ZlqRXrFs1DwtOPxEQXhCM=;
 b=f7/ZRNDmQ6MQLSD6jZvziIBTesYDSkHxt258O9mg6qDLW+SmSQKyf1CopGbv/opTNk
 2eWyCf4x2lYlc8HP+VeTHiK+VBGKTim08aWuMohWkD9RBUHnLAsOyNXP5IePIaU3qaAq
 EsydsJCrfPmNxqyG3VUmxx0wSRrF+MJs3TCBAZD4B6Ii9OuhK11DSsGmKW25lTaP/395
 nf8knD4WaPtNdH5A4Vf/fjynVP/79bU0EvertigVE4RBDl1OaTn6XCCs8BLOQ5xlkRLL
 nrSbQJj+M+sFpXNcsGASNijXfi/KlIWU5gg0x99qvgiG0bEqOku3X3XEi3Uj2P5EwP8K
 s3Fw==
X-Gm-Message-State: AOJu0YwoeOgtTUL8UeCuuk1pYcfSiXCg6aSXZ3INC56jTBRO6eaJlwaY
 v3ekNdsOTviO7wXF8q0vlg6vb2cMH6nk2DJF4lXtBYqoIdOwDQ954DqUeCZGXnx1tDI=
X-Gm-Gg: ASbGncsmOVZ6fwMlYQsljTKN9oh8HNK919xmQqxmrNw0m4oRBrUGgO5LpmhhNK9AWpV
 +wDdqt7ITGds/tES7CUD2ltOytDWlhWNZGuwoQNbGfgwB2xnusEL2z6xjOA2cgFLLvO8l4RS3dr
 fNYIg1uckBbE2LmhWCbiBwizZO+5Wa8saL018TiTbHqqk7XMoM2Nn3uxGwP4u6ncVC+cmfdP3wG
 7fFuJruYTCy92L07dEWiGUe9Vd2gz6dzZxWojX4fKzWzVGE128NbK5UmWgRuQXZPsGmSvlhBFCC
 STJPAHQneuFyp4VJBNfZM+uqOV0lORXbivXqOg803xq61Efjbk28pX8DVe5zfLX/6F4hp63OaTu
 XV/a1tiLTptNKRAXRB7OUCOXdJSPb9oG2tTLnTXDRdGdhG31s1wMAo+Fl2md0iOCT5+vH30nfKq
 0djNOsy/mWgmbn5iGCwC+JB2N+jM4FvxFG5ImtUXw=
X-Google-Smtp-Source: AGHT+IFhVL7Y0leSru0eYhtLnt2UdYp737NX50Y5jJ3AOe0hPC+6CoUZyXqQVj8pkL2cK2wxPimOSw==
X-Received: by 2002:a05:6a00:3990:b0:77f:45fc:9619 with SMTP id
 d2e1a72fcca58-7a220a08dccmr18344153b3a.2.1761005634637; 
 Mon, 20 Oct 2025 17:13:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a22ff15878sm9505087b3a.10.2025.10.20.17.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 17:13:54 -0700 (PDT)
Date: Mon, 20 Oct 2025 17:13:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, techboard@dpdk.org
Subject: Re: [PATCH] ethdev: revert reject conflicting TX offloads
 configuration
Message-ID: <20251020171352.06522a52@phoenix.lan>
In-Reply-To: <20251020123326.80591-1-mb@smartsharesystems.com>
References: <20251020123326.80591-1-mb@smartsharesystems.com>
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

On Mon, 20 Oct 2025 12:33:26 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> This reverts commit fdb840367cf0d6abeb17b05623679b8d1ea4c902
>=20
> The Tech Board has decided that the co-existence of fast mbuf release and
> multi segments is unclear, and new restrictions should not be imposed
> until this has been clarified.
>=20
> Fixes: fdb840367cf0 ("ethdev: reject conflicting Tx offload configuration=
s")
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

Although there were some warnings in CI build, these don't look related.
Queued to next-net
