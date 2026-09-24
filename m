Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C5FC98317
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2603A40144;
	Thu, 24 Sep 2026 15:25:23 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id F046A400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 15:25:21 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc433d52421so910718a12.3
 for <dev@dpdk.org>; Thu, 24 Sep 2026 06:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790256321; cv=none;
 d=google.com; s=arc-20260327;
 b=Gada9KjyCvsJQzhqK+fJcDgri/D7+JS0MqsPB6eIxZNtzpxk/0yq1UhN7vbcj9K+Ga
 3h313FF4xJxjXhmEhx8qScHQ0f4/JiVobTkFBtjX+ZYwz14IFYlPzZZy99Mlh9X9goui
 7OXEwoYG05uC4/t4hzNcYJWJeIjze1PTiaRTwAihzGYZ0CwhQm1p7LfkFYCyMaau/v99
 BpaH4ZIl4GhiXT3ylVYIPixwcDh9910HmqzwIbinv1W3Q7iaAw5zI6XYOXMgjUVxQK4W
 CPIqyLXdmT7bzy29KYO/mm8WG29h9nUBcJZBUUfVYOaBLFUrIclR9GpkJNr0BprVLUMS
 in2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=/pXppbMupf2SH6AXAdK50hRXMdwXr6JN6PXU+kTmZ3c=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=IJ8y3O3qQcLELtDFBGkOni7/VUYoF4AD6QIdUq9csmr6XJ3jkXaOwf8/F2QgJ40opm
 KflnAmrPSZi8z+X2FK8WQFjVYC2RORVE4+zIMOlE/BRlH/sqZg57Y3CWGwpzqx/mvRf0
 dyYRWRGwACFDeoa1Ya7TYTNtuNSdRB46TeOYNXNRe59WQhFHY1XIQ/sdbadK5LbvQaAD
 kX2gqZPmSYDLmk3d/NOyb8kH2HZLrqR3tc9REgaSQMRlCclTIBRDp+z4GysMyZxdpAaM
 SeNwbJ6rvQb0mPydJ803SFyZlWmBz7C5YHemN/YIsw8KuTW9m93TnuwpV9KV8JO32cxD
 6YPA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790256321; x=1790861121; darn=dpdk.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/pXppbMupf2SH6AXAdK50hRXMdwXr6JN6PXU+kTmZ3c=;
 b=PW6mFfJrirOBEuHuYyDA0IinWemyu6mM57C0pXb0EKVw0wlTi+CClgCPjM/BtAHAo3
 bKg73P0s8BsUZ+iNMap921Yznw5DE3l+RtP/YH8bZEcB58EzQMGZHmZvbYCgJ0AHC2n0
 D+yZTHw00em+Tm3Pd7j2LSV4nw6fpTwXf8WXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256321; x=1790861121;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/pXppbMupf2SH6AXAdK50hRXMdwXr6JN6PXU+kTmZ3c=;
 b=sGw5vlWQmz4nzY9tAuO5NViOpQEbDWXh56d+9jUGCBv4Wkb/Of89pRgOt1MrQJOI/J
 Rozl9CtrOexSZoLINShdBjP2MHIQT6jdDe9180h6P+jJ3m4/3np7atAyw1grPbNQuQab
 1g7huRCJGUDGgk7N0zzfQomYnAyxJ4z0h55feg1RZ0wMODrIYaM3NpmhO8UoFVAubB24
 MpKFX5SVvjh/+btN3jVrWYQxdivmW/nSdqqUDN88jcRRspZA1VndwnM7JuiQAqUt6d1y
 rsXj/Y70IJHJ7FSIjYbiIJlpQNlDi79KGRvLZP0Otk0NFEcxIHeZqZ/4GswPUc/4tUQx
 jYkQ==
X-Gm-Message-State: AFuF++k3VotVJyJ/Waurq4uexI77B7a6hTxDspgkxzyMN4Xm938vnz/i
 OgAtiIPM1N/HhBwv2C9YkJ8UqVK+d6TIJkARyrZQF/RDDSDnMVo7P9R9/Xjx4qbwn1x7zXIZOnG
 N5XgiTsJ68k65Jd1K09iRvA6FwQIGSwLH8meUiB/xGNPFEejc0US1vaGMwg==
X-Gm-Gg: AYBFou01javpM8WY9zRmZD5fH2GT4Bgr/qUa8jvLoCpunR3OF3OaqGMbR6jEEyMDBk3
 jSN/bLQXSV5Cvo3Kv3DZ6PSMRcS6FeDsK2F7uo2yBxmp6nqlmdvAZrsVctfTgi+LgEGLuy3BCmO
 uNG7CEg5I816hw0mwjzqTjGUG7CCWFGj2Bpx84GaAUmwVvzM5iAkjPJDAT+tePSO8u9PVU9zD2K
 dEhHhPTi5d83DVzzPcUCTqt1SurOT6Arqsz8iS7/Bi7YSg0BdAA88sUa2051JAu4Lc8qveo7t76
 aaXbakKYBJSlNdmWgXuCFHajSczOfd0mhUKuU8gjoZdgDng1IfnTjFa5UmIhihn5NGA50BonvpQ
 GcKk/GF8DoGLb6A==
X-Received: by 2002:a17:903:3202:b0:2da:e967:7953 with SMTP id
 d9443c01a7336-2df7dd7661fmr22664225ad.12.1790256320440; Thu, 24 Sep 2026
 06:25:20 -0700 (PDT)
MIME-Version: 1.0
From: Dillon Ladd <dladd@iol.unh.edu>
Date: Thu, 24 Sep 2026 09:24:43 -0400
X-Gm-Features: AclHuK89MgVv7A5iyEzxVm3Tdv6PkdmmWi77RCOcRJlYs4R4gkEb5KRweHxt7NE
Message-ID: <CAJA6v3ydDkqLPXtc3JLDgp0V-+o-_9CbZjV-x2gfEgRU8yFn9Q@mail.gmail.com>
Subject: September 24, 2026 DTS Working Group Meeting Notes
To: dev@dpdk.org
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

Attendees
################################################
Dillon Ladd, UNH-IOL
Koushik Bhargav Nimoji, UNH-IOL

General Discussions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Thomas merged the code coverage patch to main

Patch Discussions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Andrew put together a list of patches ranked by priority for review:

DTS Framework:
---------------------------------------------------------------------------=
-----
1. DTS: Rebase from Dean (API updates)
https://patches.dpdk.org/project/dpdk/list/?series=3D39153
Andrew has made adjustments from Luca=E2=80=99s feedback, pending review.
2. [RFC] dts: resolve trex driver binding issue
https://patches.dpdk.org/project/dpdk/patch/20260811185509.1650102-1-knimoj=
i@iol.unh.edu/
Prioritize review, sizable change of DTS and it would be helpful for
Koushik to have feedback sooner opposed to later.

New Suites:
---------------------------------------------------------------------------=
-----
3. [v3,3/3] dts: add verify coverage for cryptodev testing
https://patches.dpdk.org/project/dpdk/list/?series=3D38682
Pending Review
4. [v2] dts: add pvp multi paths vhost performance testsuite
https://patches.dpdk.org/project/dpdk/patch/20260908144707.862960-1-knimoji=
@iol.unh.edu/
Pending Review
5. [v1] dts: add pvp multi paths virtio performance testsuite
https://patches.dpdk.org/project/dpdk/patch/20260903201155.817724-1-knimoji=
@iol.unh.edu/
Pending Review
6. [v3] dts: add ipgre test suite
https://patchwork.dpdk.org/project/dpdk/patch/20260914200019.958925-1-abail=
ey@iol.unh.edu/
Pending review

Test Suite Extensions:
---------------------------------------------------------------------------=
-----
7. [v1] dts: refactor cryptodev throughput test suite
https://patchwork.dpdk.org/project/dpdk/patch/20260827172208.139769-1-abail=
ey@iol.unh.edu/
Pending Review
8. [v1] dts: update configuration for performance test
https://patchwork.dpdk.org/project/dpdk/patch/20260805153658.345207-1-abail=
ey@iol.unh.edu/
Pending review
9. [v1] dts: add PVVP case to virtio suite
https://patches.dpdk.org/project/dpdk/patch/20260811171235.519323-1-abailey=
@iol.unh.edu/
Pending Review
10. [v7] dts: refactor flow suite with generator pattern
https://patches.dpdk.org/project/dpdk/patch/20260811170433.517663-1-abailey=
@iol.unh.edu/
Pending Review

Bug fixes:
---------------------------------------------------------------------------=
-----
11. [RFC] dts: restore unbinded ports to initial state
https://patches.dpdk.org/project/dpdk/patch/20260812194428.296334-1-knimoji=
@iol.unh.edu/
Pending Review
12. [v1] dts: remove crypto test type
https://patches.dpdk.org/project/dpdk/patch/20260806164505.642928-1-abailey=
@iol.unh.edu/
Pending Review
13. dts: update verbose output regex for VXLAN packets
https://patches.dpdk.org/project/dpdk/list/?series=3D38925
Pending Review

26.11 DTS Roadmap
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Finalized roadmap is out:
https://mails.dpdk.org/archives/dev/2026-September/345096.html

Any other business
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Next Meeting: October 8th, 2026

--=20
Dillon Ladd
Technical Manager, Open Source
21 Madbury Rd., Ste. 100, Durham, NH 03824
dladd@iol.unh.edu
https://www.iol.unh.edu
