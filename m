Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630FBCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 15:30:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3B914026C;
	Fri, 15 Aug 2025 17:30:24 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 5D5434026A
 for <dev@dpdk.org>; Fri, 15 Aug 2025 17:30:23 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b471738daabso1831096a12.1
 for <dev@dpdk.org>; Fri, 15 Aug 2025 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755271822; x=1755876622; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fl+ZiJmD6h+fhOYMGVQScESMxkp/TUTz60h0iOTLBvM=;
 b=YkKOWt3HN6Hgcfzi/M5CI7qZlvDwo/7Y+uWp9XH5mdSsB/Z5QY/Rf80Uu3o0t8SbEH
 vpBgxcSLsCR9tbRRbacSdHVy5+dRmslLZYG5PxZ2zR/fruu+1km0uUI1cAg0rQiV5Qqh
 1s8v4QX+jfKJ6w3ScplWGA2IH14BQOh9aiCpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755271822; x=1755876622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fl+ZiJmD6h+fhOYMGVQScESMxkp/TUTz60h0iOTLBvM=;
 b=TCbq1jSzS8/gd1fMqLdtJLayqdPxNDR7lZ+wpfFJ4ZGVMrIivtDD6KJEcIDeocR8l7
 BRS2Nw/yVrxjCIGh3E1STFmWNANRe4BYwWAwASefC1dZ2LMic3aOQwMbE27CtygC9FCB
 27B3BEMpzhSqm62pigHZvMn219xxMpoqA4MP+UrdAwpUz1a2ICbrncvjvozJzxCmWyB1
 anWtLhhlIocUl+W3NIJ/kOWArDPgxI++qfLT+4WqcTJsirCW9OOzHSf9UuVgTnTzY4Va
 7UvCKnrg0SSnVh2/DQ6q4MfJd/LXv/GBXJ9CztDLEAN6E+ezXYuIQBuFGMaS2KscK8zG
 lghQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl/PMThoSDeZumq+649u2BuDIjD1LES+88Pw6kGqYw5nFWxqlQcwm7p9ydOzbUNMjADTQ=@dpdk.org
X-Gm-Message-State: AOJu0YwxfIRjNvXdUtJ3CLkm36Ru51YwrTZ9VffK0bfbIV65gxZRU4b4
 AcetSd0tnmtbDYw7hglM+0tG0rKR7P4nMtjIGWz3Le1roiWvFEJsfgarXXH7CKYSoNrNcW7aqvv
 iFKe2feAb6bB5JEyceIDzmGJgfM/eL/XQZWh4bezSkU04DGYHv3P11iE=
X-Gm-Gg: ASbGncuczZEN2J039krL9PoazsujZ5ez2IZ89sk8mwdhcLLSR09nZ81HH0xPGp/kfxh
 3+H1ivjB6Hq9O41hNhSxvY7rSYJ7Fnh93tbaz+HMmyaB8M/b9cQD04daGb6lLT6LDeF4BT9Noub
 TtFqP/S3GJUNxSxXgost2qysyULzBQ6Idq9eGAHoQFnfLnOQhjQXjtbeaTMYrhV41aojzd1qcl1
 x8cPSNO+Bod5Oj8nyUhkdRowxcseK6lzHRGzBX+
X-Google-Smtp-Source: AGHT+IGtTqy00aY9Iysedjyz6cvzPKPcGCsFEe1dX1OG0PZ6bACp+TmbmU2bWOf337KMbYvrxADKlobf3+DaSuCqSFM=
X-Received: by 2002:a17:903:950:b0:242:9bbc:c775 with SMTP id
 d9443c01a7336-2446d987fb6mr41196845ad.56.1755271822444; Fri, 15 Aug 2025
 08:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250808071048.1906724-1-wang.junlong1@zte.com.cn>
 <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
In-Reply-To: <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 15 Aug 2025 11:23:56 -0400
X-Gm-Features: Ac12FXx38-3yxxvNRKEr3BMxtj6jREcyOIIpfBEPAaKnzC_GcZ7zT0YOCplz7vY
Message-ID: <CAJvnSUDdX8u8AfQ388vAbowmv3DTYES69Hkp6u-dRaDZc5O7-Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] add support flow director ops
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: stephen@networkplumber.org, ivan.malov@arknetworks.am, 
 wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000076235a063c6911b4"
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

--00000000000076235a063c6911b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sending a CI testing retest for the v5 of this series because of a
suspected false failure on the packet capture testsuite.

On Wed, Aug 13, 2025 at 11:03=E2=80=AFPM Bingbin Chen <chen.bingbin@zte.com=
.cn>
wrote:

> v5:
>   - modify some error level printing information,
>     and other issues from Maintainer's.
>
> V4:
>   - replace rte_malloc with calloc in the flow_dev_dump function.
>
> V3:
>   - fix several checkpatch warnings.
>
> V2:
>   - resolve code style and gcc compilation issue.
>
> V1:
>   - add support flow director ops.
>
> Bingbin Chen (2):
>   net/zxdh: npsdk add flow director table ops
>   net/zxdh: add support flow director ops
>
>  doc/guides/nics/features/zxdh.ini  |   16 +
>  doc/guides/nics/zxdh.rst           |    1 +
>  drivers/net/zxdh/meson.build       |    1 +
>  drivers/net/zxdh/zxdh_common.h     |    1 +
>  drivers/net/zxdh/zxdh_ethdev.c     |   26 +
>  drivers/net/zxdh/zxdh_ethdev.h     |   12 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c |    2 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |    1 +
>  drivers/net/zxdh/zxdh_flow.c       | 2017 ++++++++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_flow.h       |  240 ++++
>  drivers/net/zxdh/zxdh_msg.c        |  264 +++-
>  drivers/net/zxdh/zxdh_msg.h        |   31 +-
>  drivers/net/zxdh/zxdh_np.c         | 1638 ++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_np.h         |   31 +-
>  drivers/net/zxdh/zxdh_tables.h     |   10 +-
>  15 files changed, 4217 insertions(+), 74 deletions(-)
>  create mode 100644 drivers/net/zxdh/zxdh_flow.c
>  create mode 100644 drivers/net/zxdh/zxdh_flow.h
>
> --
> 2.27.0
>

--00000000000076235a063c6911b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+U2VuZGluZyBhIENJIHRlc3RpbmcgcmV0ZXN0IGZvciB0aGUgdjUgb2Yg
dGhpcyBzZXJpZXMgYmVjYXVzZSBvZiBhIHN1c3BlY3RlZCBmYWxzZSBmYWlsdXJlIG9uIHRoZSBw
YWNrZXQgY2FwdHVyZSB0ZXN0c3VpdGUuPC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
IGdtYWlsX3F1b3RlX2NvbnRhaW5lciI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIi
Pk9uIFdlZCwgQXVnIDEzLCAyMDI1IGF0IDExOjAz4oCvUE0gQmluZ2JpbiBDaGVuICZsdDs8YSBo
cmVmPSJtYWlsdG86Y2hlbi5iaW5nYmluQHp0ZS5jb20uY24iPmNoZW4uYmluZ2JpbkB6dGUuY29t
LmNuPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQg
cmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij52NTo8YnI+wqDCoC3CoG1vZGlmecKg
c29tZcKgZXJyb3LCoGxldmVswqBwcmludGluZ8KgaW5mb3JtYXRpb24sPGJyPsKgwqDCoMKgYW5k
wqBvdGhlcsKgaXNzdWVzwqBmcm9twqBNYWludGFpbmVyJiMzOTtzLjxicj4NCjxicj5WNDo8YnI+
wqDCoC3CoHJlcGxhY2XCoHJ0ZV9tYWxsb2PCoHdpdGjCoGNhbGxvY8KgaW7CoHRoZcKgZmxvd19k
ZXZfZHVtcMKgZnVuY3Rpb24uPGJyPg0KPGJyPlYzOjxicj7CoMKgLcKgZml4wqBzZXZlcmFswqBj
aGVja3BhdGNowqB3YXJuaW5ncy48YnI+DQo8YnI+VjI6PGJyPsKgwqAtwqByZXNvbHZlwqBjb2Rl
wqBzdHlsZcKgYW5kwqBnY2PCoGNvbXBpbGF0aW9uwqBpc3N1ZS48YnI+DQo8YnI+VjE6PGJyPsKg
wqAtwqBhZGTCoHN1cHBvcnTCoGZsb3fCoGRpcmVjdG9ywqBvcHMuPGJyPg0KPGJyPkJpbmdiaW7C
oENoZW7CoCgyKTo8YnI+wqDCoG5ldC96eGRoOsKgbnBzZGvCoGFkZMKgZmxvd8KgZGlyZWN0b3LC
oHRhYmxlwqBvcHM8YnI+wqDCoG5ldC96eGRoOsKgYWRkwqBzdXBwb3J0wqBmbG93wqBkaXJlY3Rv
csKgb3BzPGJyPg0KPGJyPsKgZG9jL2d1aWRlcy9uaWNzL2ZlYXR1cmVzL3p4ZGguaW5pwqDCoHzC
oMKgwqAxNsKgKzxicj7CoGRvYy9ndWlkZXMvbmljcy96eGRoLnJzdMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB8wqDCoMKgwqAxwqArPGJyPsKgZHJpdmVycy9uZXQvenhkaC9tZXNvbi5idWlsZMKgwqDC
oMKgwqDCoMKgfMKgwqDCoMKgMcKgKzxicj7CoGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9jb21tb24u
aMKgwqDCoMKgwqB8wqDCoMKgwqAxwqArPGJyPsKgZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRl
di5jwqDCoMKgwqDCoHzCoMKgwqAyNsKgKzxicj7CoGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhk
ZXYuaMKgwqDCoMKgwqB8wqDCoMKgMTLCoCstPGJyPsKgZHJpdmVycy9uZXQvenhkaC96eGRoX2V0
aGRldl9vcHMuY8KgfMKgwqDCoMKgMsKgKy08YnI+wqBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRo
ZGV2X29wcy5owqB8wqDCoMKgwqAxwqArPGJyPsKgZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cu
Y8KgwqDCoMKgwqDCoMKgfMKgMjAxN8KgKysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj7C
oGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmjCoMKgwqDCoMKgwqDCoHzCoMKgMjQwwqArKysr
PGJyPsKgZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jwqDCoMKgwqDCoMKgwqDCoHzCoMKgMjY0
wqArKystPGJyPsKgZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5owqDCoMKgwqDCoMKgwqDCoHzC
oMKgwqAzMcKgKy08YnI+wqBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuY8KgwqDCoMKgwqDCoMKg
wqDCoHzCoDE2MzjCoCsrKysrKysrKysrKysrKysrKysrKys8YnI+wqBkcml2ZXJzL25ldC96eGRo
L3p4ZGhfbnAuaMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqAzMcKgKy08YnI+wqBkcml2ZXJzL25l
dC96eGRoL3p4ZGhfdGFibGVzLmjCoMKgwqDCoMKgfMKgwqDCoDEwwqArLTxicj7CoDE1wqBmaWxl
c8KgY2hhbmdlZCzCoDQyMTfCoGluc2VydGlvbnMoKykswqA3NMKgZGVsZXRpb25zKC0pPGJyPsKg
Y3JlYXRlwqBtb2RlwqAxMDA2NDTCoGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmM8YnI+wqBj
cmVhdGXCoG1vZGXCoDEwMDY0NMKgZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cuaDxicj4NCjxi
cj4tLcKgDQo8YnI+Mi4yNy4wPGJyPjwvYmxvY2txdW90ZT48L2Rpdj4NCg==
--00000000000076235a063c6911b4--
