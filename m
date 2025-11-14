Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296B9CE8D76
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 18:25:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68A9C41133;
	Fri, 14 Nov 2025 19:25:54 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9115340E34
 for <dev@dpdk.org>; Fri, 14 Nov 2025 19:25:52 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-29853ec5b8cso26990825ad.3
 for <dev@dpdk.org>; Fri, 14 Nov 2025 10:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763144752;
 x=1763749552; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oy2zYLYWHVcqAcNhNMlwSpAgCH1EssbAaINW13adjiU=;
 b=ASXRKuc4jsqHTWFmwin1Gv2nSiTBeY+QUTgoykErY+ARR3osYZp5IgMQCxCGrSX5m+
 E3B6jr27q5syDNxM3iW9r+7rs+TzBifUh55lwMEyluhJadKyvDKhmhV6qGgx/S3uJdJK
 QhHu6K+L2XQGXFH7hLUFGCQw8uBGFQKKjVGO3LjX9wyyumducP5nXfXiZAcKzPyXxicn
 RG+tj14jA5sAlhTZheERBd7mfvkF8LgGArjXI4YEu2MBs3W5frVHc5NjeyRQlwhnfA24
 OSlYIweu2T/PUvfcQ99THW8mOSjJrqtoYw+DmkVu7CS0Fstp7gPID7DD/eVau/jmuDOn
 tigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763144752; x=1763749552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oy2zYLYWHVcqAcNhNMlwSpAgCH1EssbAaINW13adjiU=;
 b=B/9LXdY2HmOhqXO908khlkszu2B7SccTFwzd1b9wWR+NnzpavnVfqCdBnaAqirNjRV
 Y6/H9+zTJwWEVFzgh7EeSWwOw0jVKgTSKxwTb2gyujechnBlkcf9TrHXqLzGU++SfX0q
 pA+MJZHU875Ceu54FinHwY2UAU3XNyp4GjOzX4s2lIfld5V5EtDmn5rwNGrPmoK63vNv
 czJrc2lUWI2JpakpiKaLvDcowoFPFCYCEQXGAyOTEMn53vVCkJpn3k2HUeBRbAgNs4JJ
 9lJsjovIZu8sSAX4OehSJS3uFc0sOFkSzYP3La4lE+Bx1OZapu+q699aMPsF8wA/PEU3
 ToKQ==
X-Gm-Message-State: AOJu0Yyn+yuPE84FfpbJbovUgO2E8mJY9xzztP9lrPd1HdloP7nsMiez
 R5ZboRU6npVaZEctOIPwq5STMtmjrO0Nv+HABYFj+O79+tCZMspraFVA4bcBh7pT4/M=
X-Gm-Gg: ASbGncv8W/kgtRNR6578VxpeOeWynCfoZcKGX6qLghrzfi9yIoNRwCqup6+BnF3I7L2
 Custoow2R0BQxD9hDn+XQROhqEZ5VwDwradbs4zgOeFm4NDGwjMNWo54P7eeM46MveOM2cFtsVV
 muq284rGiSKfd55Oyw3EXM9w6MbGrAZekWQigYIXTOegaMpoV6iuzpn2W+jYGQsffz7zzp2LJr7
 1I8hwJ2eT/jKtVwAfoeRiXp7oziukNKmrpCFVNCQ3eU5gTPTcEMkMpgXc92zJ9+euzx0y8ulk07
 ni3AdB5bJU+OjN6KjAV2fxLnU/Kopcye7SoBWmUCB27hERa8ZJmxBYOs1bcUx4lKiVFVJz0CLg2
 AQiZQwHQZsi5AKcmt8RAXV3Hi71o985MiU1q1UYYqITpOQfgDijbys9R+mX1k2+6ZI373yIGD6L
 vBqqovgOztDqD0MjErFpqPg2FaQBArVy/I48koVPhqFbxC
X-Google-Smtp-Source: AGHT+IETMOhc88YIpT0SVFBoUBaHywmM+sSPhRPz1BY9cqnD/D2alG2LQnEsJgUtkhF7LbsyLOBtPw==
X-Received: by 2002:a17:903:19e3:b0:297:f8d9:aae7 with SMTP id
 d9443c01a7336-2986a7556ebmr46785795ad.46.1763144751594; 
 Fri, 14 Nov 2025 10:25:51 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c23849esm62621735ad.5.2025.11.14.10.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 10:25:51 -0800 (PST)
Date: Fri, 14 Nov 2025 10:25:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/axgbe: fix the build warning for GCC-16
Message-ID: <20251114102545.783dd27d@phoenix>
In-Reply-To: <20251113164109.522-1-VenkatKumar.Ande@amd.com>
References: <20251113113055.371-1-VenkatKumar.Ande@amd.com>
 <20251113164109.522-1-VenkatKumar.Ande@amd.com>
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

On Thu, 13 Nov 2025 22:11:09 +0530
Venkat Kumar Ande <VenkatKumar.Ande@amd.com> wrote:

> Build warning reported for local variable set and not used on GCC-16.
> Fix the issue by using the variable for missed register write operation.
>=20
> ../drivers/net/axgbe/axgbe_ethdev.c: In function =E2=80=98axgbe_timesync_=
disable=E2=80=99:
> ../drivers/net/axgbe/axgbe_ethdev.c:1744:22: warning:
> variable =E2=80=98mac_tscr=E2=80=99 set but not used [-Wunused-but-set-va=
riable=3D]
>  1744 |         unsigned int mac_tscr =3D 0;
>       |                      ^~~~~~~~
>=20
> Bugzilla ID: 1819
> Fixes: e04449488fdb ("net/axgbe: support IEEE 1588 PTP")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>

FYI - mailmap treats mail addresses as case sensitive.
Therefore the entry in mailmap (venkatkumar.ande@amd.com) does not
match the From or Signed-off-by causing warnings.

Do you want me to fix mailmap or the submission to match?
