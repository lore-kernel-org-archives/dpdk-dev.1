Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A56C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 20:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81FC240268;
	Thu, 20 Aug 2026 22:16:50 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8B584400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 22:16:49 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so216609b3a.0
 for <dev@dpdk.org>; Thu, 20 Aug 2026 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787257008;
 x=1787861808; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=szVM6RP4G1zr1kHJF2g00LqAQ+44PbSTauBih/jnQ4A=;
 b=JqP9m/FKHKzYOQu9lE/DcJW5CyPGL1X4/6jP8bglZyVGpJHoMtYT3I4eGUvMKngtES
 oVlY1mrcTZWafHX+V9EV7GR7UgbXphffpUEC9Enub2Ij6iG80WHpk1ALbSkcgOeHmtDV
 0REtVvMZSKCct3Cx2hEfTZzzT63y9Va5Teg8CcJWqHAcp/od2h+Qbb3RavrucEoxYC9a
 5OE8SD5tfpffgTX/gIfZ7RG9It4D3RtwJQpCI9Y4KNrrdONVOLn/wkwphELT1K6OWb5O
 FNsxXWqHcKJLc1quVEe1nBhat13rX6VIKlVzPd2k6CQlBny8I45sNGByuh70ifSehaTw
 vbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787257008; x=1787861808;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=szVM6RP4G1zr1kHJF2g00LqAQ+44PbSTauBih/jnQ4A=;
 b=Vz4GooFFJ0VhoDH7jrD6yWUK18EuIK2cNOZXcpzrx5XZKqHRAr074swbrHR5vSD9G2
 gUNkEZB49Wnx8hBrbaz/S84ai2C5T8aldWfVtny+5yswVmsNQiMxtEp89CUe339Co1MQ
 kqahjdJLrTcpYGVRtcpdIcaX4ozew2sKBTFs3/78B5eLTzc0ToAkoZqp9hwnGAP6/9x/
 G8lvMrVBjqrGGBK0QqDqysKDOUyomp/CSbwZwc+OPJ6xeh0q6fjgrqtfLI+DnXs+yX2E
 3qvI8ud1AqIuqQetmD+fF9Jdcem3fbOCb0WwQDgWz5On5VLF2vbBpsYjnOD5f/G/kksN
 lx2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+f+JTyE2YN9SIJ3NzIR55Cw3nDJqqhXiTcWDBDDadyNczdpXjQUE7aLZAtpmjIVjqVr0=@dpdk.org
X-Gm-Message-State: AOJu0YwOfw4F4vt3WrVgleyjFUBGyWqVzB/n3wLC/TJdb7s1BHLjQpOM
 cAw8D+6IRHfzte5SB7603xqR7kUHky34UYkXX8oO2N6vK0KqAf1tvZwoWRKwu4B++dE=
X-Gm-Gg: AR+sD13IvE6Sy9m5G+xgBjyFwlf1yNYtzPb+qGJeGyN68Cb2nPWBA7vz31TfRS6G9Gw
 JQkY9gneLFowh6NjLbc5yh97/twu/9EFP0et3zy40q8EYuEilhEBKHGTo0hY/dG+RHWlyyE+An1
 hSeKQ4QvhBBmF82j50ewe3KBht4WxOGpKe5pkxnNnOYWy10OHfBq7NuKwpb64x2aDjwWgWNOFOf
 hVAbaYyAWJXRjpWqeEFu8FzlfLH5Wpgfcj2PjZnZ6Ddtr3GJgSetV6gU9mAOGaLyHAy7rQ8mu+j
 FDpObF4Es2skVQiANhR2sHTxhx0nkLZcesUefOa2bpG2doZ36OnLbdmSyt3G1CMMe8yNVrTbS/I
 IGBkTEIuUDqyO2pMPy4//BjxmtXu0/sbl+rqwqKvjHGnDgNL659wbUsa9S9B08CU/dpk7lonPCX
 wQiGgS3hHHfDiJeO2zii7AUqNHG2+m9JRAXTqizVPB7KZcxi6TETx99oJwRBS3QAqagiCKRIK5j
 32TcbPQSq5CJ8MmcVG8nLu5CPoFog==
X-Received: by 2002:a05:6a00:439b:b0:851:b007:2fe0 with SMTP id
 d2e1a72fcca58-851f9a253a5mr1188797b3a.1.1787257008406; 
 Thu, 20 Aug 2026 13:16:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d33a5b72sm2071878b3a.23.2026.08.20.13.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:16:48 -0700 (PDT)
Date: Thu, 20 Aug 2026 13:16:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH 00/61] reduce use of rte_memcpy
Message-ID: <20260820131640.25031028@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A01@smartserver.smartshare.dk>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
 <42ecbb8129514f52b456549ee66757b2@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65A01@smartserver.smartshare.dk>
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

On Thu, 20 Aug 2026 11:03:13 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > For those on the DP, at least for some of them we can run perf tests:
> > let say for hash we do have perf_autotest which can be used to measure
> > the
> > perf diff. If there is none, or neglectable - then no point to keep
> > rte_memcpy here. =20
>=20
> Unless that perf test is run on all platforms, the result only shows perf=
 diff on the tested platforms.


There are also important DP (virtio, real PMD's) and test tool DP (pcap, nu=
ll, and test code).
The former need careful work, the later really don't matter with the .1% de=
lta from memcpy.
