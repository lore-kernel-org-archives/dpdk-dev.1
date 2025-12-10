Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DF2D3C91A
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 15:02:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 668DF4028F;
	Wed, 10 Dec 2025 16:01:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id ED3D140285
 for <dev@dpdk.org>; Wed, 10 Dec 2025 16:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765378917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=kT/uHAwbB87P5hgt11FnKX30BKwEmKSEj0p2mxkuVNM=;
 b=NZ7zWTxKrGtS4eYSJ893v3edzLQ8fBocRLth79x79ZkQ+tqjf2/TxV+r0BV8r80yPKzbI3
 u7zl1ivXID8Q8dWtrrlqUsOQLSfCa9oRo+9eiXCj4qzZXDYS0yQYaOxzYXXOsN5/SWwW87
 ZrvlkakSExbAajusBefD6/EkeL03rlM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-_0RFYWCDNWimhYcl3A5Npg-1; Wed, 10 Dec 2025 10:01:56 -0500
X-MC-Unique: _0RFYWCDNWimhYcl3A5Npg-1
X-Mimecast-MFC-AGG-ID: _0RFYWCDNWimhYcl3A5Npg_1765378915
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso61697645e9.1
 for <dev@dpdk.org>; Wed, 10 Dec 2025 07:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765378914; x=1765983714;
 h=content-transfer-encoding:to:autocrypt:subject:from
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kT/uHAwbB87P5hgt11FnKX30BKwEmKSEj0p2mxkuVNM=;
 b=eJ6I/VqAXy2eNzLCeINbNiNOrOnc1v7ZzNfunLaBRH8Y6EOLyytdPvjwd8jiMTN1Oj
 NgDziHiB/7mIJBEp62YCRN7zRHWPrOKTDONNmM7RYgO6R7vgpquWHqSt8XLHSFBVAPiN
 rgkNJSWQXexIXTMyKSk+CHGHbgOeDBWbRM8OTbrffy+2/n/zqAb3WGbKKy7bkvoXwJD1
 vS5IPx842NfCqYJP6jxkzhB+sfkB6lIulzPNMSrEQM1eqCXTzoK3BiorYfCcDn0Psv8X
 8rWOW2hrQteYXlFuesqAxSIpa8/dS0msoyqYeI1oCWkLdmXP/OfVs3onrmUL0LQUk/uP
 opeA==
X-Gm-Message-State: AOJu0Yy0NdZjlCqUGG0ctHghKAimE4q0uZ0s6TFwWz38z+TF86bspOkH
 pUdagpuAjtvhSyqNcPLNYjIssOulcTVU015C0VJ5mUqL6v9hZlQcbwrvNXPufMuHHRJCwkRCTKs
 HxNFHd/08a3TMdDAHonZO0LrwCrb64rHG/b5vRMiij6d44eleTpcoaDXvZqJxCvYmVKk/WK0Kzn
 6xendvSzfj0cXvygH/NqlqWUlz7GMZ
X-Gm-Gg: ASbGncscZQY4IDiU1sGw/z/tD1TZXT7grkcj19Qx/DBmJTqEFa7tlS+e0MxQoUodIix
 K5H/tgPa/gE+2xo4UozKml9ow5gRwsE6R/IoBArOG7rJ+tiVTBYjFT7Deg6SIAVceNm8EjEo6Gj
 Q+feddQQXRi7FP5xxwxCyNGpM4GbK6cvdps8pIhK7rhWM8sgfKUbKcHPA+gXbfTiWuV9J4D3UVj
 8R0Y8IiutmmG+JXorczRcqWccCYTo9UJ87BcowtK+oG2LjWGRyL9pv4VwXKvRerovp2vFtadYKA
 cqOtLRTyQCv5xazrUkqR9rHzFGMhXWQYO+sm1n7LGhyJnlC3Rzx7QtUZscsGKptBFQNVYw8CsOe
 blIKinBs/QnYe
X-Received: by 2002:a05:600c:1909:b0:471:115e:87bd with SMTP id
 5b1f17b1804b1-47a8384cfa1mr27088775e9.26.1765378914269; 
 Wed, 10 Dec 2025 07:01:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGydobjhsqn2ChuqK+OFO6PANHFZ0kFb+F4knxHbzoFwLYB6HvgEdvHdD16DtM1Ygmk4Oz5uQ==
X-Received: by 2002:a05:600c:1909:b0:471:115e:87bd with SMTP id
 5b1f17b1804b1-47a8384cfa1mr27088215e9.26.1765378913632; 
 Wed, 10 Dec 2025 07:01:53 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7da4885esm41254495e9.20.2025.12.10.07.01.51
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 07:01:51 -0800 (PST)
Message-ID: <d4dccf88-6813-4bbc-b75e-a8ea4240ce1b@redhat.com>
Date: Wed, 10 Dec 2025 15:01:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kevin Traynor <ktraynor@redhat.com>
Subject: Minutes of Technical Board Meeting, 2024-November-26
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
To: "dev@dpdk.org" <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L_bAw-Ba3d4OGvMXCWCScTfjGJTokeTA5HirG8hW-yQ_1765378915
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Minutes of Technical Board Meeting, 2024-November-26

Members Attending
*****************
- Aaron
- Hemant
- Kevin (Chair)
- Bruce
- Thomas
- Morten
- Stephen
- Konstantin
- Jerin

NOTE: The technical board meetings every second Wednesday at
https://meet.jit.si/DPDK at 3 pm UTC.
Meetings are public, and DPDK community members are welcome to attend.
NOTE: Next meeting will be on Wednesday 2024- Dec - 10th @3pm UTC, and
will be chaired by Honnappa

# Lab SoW

- We got tech board quorum for voting for 2026 tasks.
- Patrick processed that into an SoW
- Governing board approved
- DTS development work being discussed

# Discussion of VLAN offload in PMD

- Discussion over patch for nbl driver that hard codes a return 0 for
vlan_offload_set callback
- https://inbox.dpdk.org/dev/20251124153545.7123c338@phoenix.local/
- vlan offload is done in software
- Issue is that existing OOT driver does this, so it would break apps vs
in-tree driver if it returned ENOSUP
- For current release, leave code as is
- For future release, consider to do some validation at ethdev level

# Driver Maintenance Discussion

- No updates

## Follow-up / Action Items

- Await update from Ajit regarding the new Broadcom maintainer
- Await Broadcom's plan for ongoing BNXT branch maintenance
- Discuss adding support-level flags to the maintainers file.
- Consider updates to documentation or policy for driver quality
expectations.
- Stephen to share proposal for marking drivers support-levels.

# AI
- Aaron ran some experiments in OVS using Claude code and Sonnet for
code review
- Results were better than CodeRabbit and Sourcery
- Aaron will select some DPDK patches to test with it

