Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17581FF60D9
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 07:38:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC035406B4;
	Tue, 31 Mar 2026 09:38:04 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 9A53540269
 for <dev@dpdk.org>; Tue, 31 Mar 2026 06:45:45 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-486fe655187so67980635e9.2
 for <dev@dpdk.org>; Mon, 30 Mar 2026 21:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774932345; cv=none;
 d=google.com; s=arc-20240605;
 b=UHej4fNtyKe0qBc2+NmPbEbkP4dK815vURZ3MCvtc1ketpLM3gI7b1PzWjJJhDQbzv
 /KKJsEdr/xZHMkn1GvTJ4Qk4vorJ+qxCPf4rkxIhe6czmpQIppBzLiG+1QRlWPSkznkK
 W9p4CBQuVSfdqBVW+QQl2i9sR0qZOJLpCRx/CW+epzhVvLiNPmTXQ83BYXhJIn2nDuEY
 BD+/oeUBcFf9112iS4//BengjlQJnqYqxwhlQq5ykndB0v+pRKGH430vGPb3AoY5hZZQ
 bh1BmvY86NYeR712fzorcJy/Gl2I4nKK1pv2XPzmQXzO735y+/DE4v983spSl12F32wJ
 q2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=gnX1Ic/pBW8U5R/ejdCY2zS8apwgrvFyGXfObj5+14I=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=cDQsUFEtF1A2cyXAdg9K5JpPu/1MfluvC9/3qtUuZSdMzDcBp4JS1L5YRyb48vQsoH
 juCs2Ui6voHaskI+9BrLQJEepuIELu9gktz1W8Dqk6msKkBcIF3bq5OE1th4TMavQVTT
 yiaLa9X4PgbB1+Fo9rJsYwsy+btairoy/Ve2Mvp2ikE5b4hPIQYS8dcPbXUGmxOCvORM
 UuFguHmm0JEpHXjtjOCP6WU3tQmcECIfG9ZjhMpdDIcSCQGPKP2FZl8Xh/0SKfEjueea
 19loj2aRPN1iI4zk8vB1+oY3/6RPUzIXQ5j3QThAogGUPX3NSl5uconCFmQ2dGuZpm4b
 xljA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774932345; x=1775537145; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gnX1Ic/pBW8U5R/ejdCY2zS8apwgrvFyGXfObj5+14I=;
 b=BmI8v97XUixhw55Rq06heykuQZToY+P4OlhcmMgz19Czeqp238GyxWXKK8r2rswnqL
 JR8YfuW89NSjDYxdKQgaOei3kDD1K2/PeIS20bc1PdVlCVCAtT2FhlIUVeasYimm7cdt
 jo6sToJvOvsHxd0gOZ2435X7iVrd8PRFqSlR9cS8hwz179VWLJijqUWZ3hwN63n4RbQj
 xRl7A3wUK76AWYP59LslcCeAhPCFCQMTDU3DbsxhJ4+TPb2nYM8BHBxK5+zKumYsFcUs
 YFu+0B6ObMBcO7zk5gVMnn/TGsmLnnJEebWhUttfBgmaG10zJi3bOeGJM7dGCKFp4dEA
 F5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774932345; x=1775537145;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnX1Ic/pBW8U5R/ejdCY2zS8apwgrvFyGXfObj5+14I=;
 b=dO90qKJ3QHgwVeCnv1GvKueINHA7sul8FWthR8P1GjZPZH6S6xyVRbicH8eHiUV1ED
 5/LRYuku1HwNLlZsUMccg7Kpj59cMZl4Bt6xNFCmcjI1VXEG4Nf/95MIJuks+/8xHwnP
 AMCVR7gVXatCaFcNCuNzEF/kHoYG9BkARxfAXCOTpCcjpP5kVtYxNCJoOE0i1i+WkTBH
 Enc+yEZKOF+n6qBkXEgky9SEGeHMdBN3KZaBKift0SkojCqeqyT/efx+Py2UPYYF8z4/
 bUqLk5Tdlwyfaj9wor/Wt9QdAa7za1NAZ3cy64YdT/VzOAhcj51+qhpsh1RAz5t/YOx6
 BWDg==
X-Gm-Message-State: AOJu0YzFEpy8jg+/uqTbsrM7a7vpqredG0OknD+j5nbYEIN3VCzjo0ue
 b+w8YdKaLJc6BvYFJx0U2xp715kQocq3mbjmNgGs/35vNoLQ394gXcZynHSAa1/QXKY2wt398hW
 eC5OiuAfcvVk7ULr2EH61YOYkJH5PmU7z94tR
X-Gm-Gg: ATEYQzyzIe3Vi2mhKvkIznOfsg38dDPCOixEGWwdsXvpfdLJUcIxzoI4FqmM3hWsvzJ
 Tyoa9/nW9SUo25a8oMAhbHXgi+Tac/A7DYKUn2cQBIqbm8zV1nMsh+WbcNY6PQSQ9mwUYqSM8zp
 r7PHTfGU1CMM6d21BQf20ATKnePvdzS2x+2gzr15PhLMmFmnqbGlRv5J8xg1gu7AqXNsVPXHFXa
 LPV5PgXB1Fs4j+3GmRPPc7PthwfYp2xPE8Q0wEOskIoqHoCxRgfycV8PtI/gCI/w8+9/kXmdIxW
 AeyVRO7Z1rDLqK05W+zXbxG93q9wL51Dv7RRP6fIco6dlYbRIQjO7VmcxdW+Stbt32AF
X-Received: by 2002:a05:6000:428a:b0:43b:5b25:67ff with SMTP id
 ffacd0b85a97d-43b9e9a97e9mr25781396f8f.24.1774932344776; Mon, 30 Mar 2026
 21:45:44 -0700 (PDT)
MIME-Version: 1.0
From: Harsh raj Singh <singhharshraj215@gmail.com>
Date: Tue, 31 Mar 2026 10:15:32 +0530
X-Gm-Features: AQROBzA03sVQnL8zf2-zPTFyhYFGUwEeEE5s5I9Ehqip4HGCXtv0ZWz-4RrbYJE
Message-ID: <CAN33txFohZzwnKJ2uTDyMuQ9fWpMvJQ=6BCr-TURU19RV9EY8Q@mail.gmail.com>
Subject: [PATCH] examples/l2fwd: fix port statistics reset inside loop
To: dev@dpdk.org
Content-Type: multipart/mixed; boundary="000000000000e93e28064e4aa37f"
X-Mailman-Approved-At: Tue, 31 Mar 2026 09:38:00 +0200
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

--000000000000e93e28064e4aa37f
Content-Type: text/plain; charset="UTF-8"

Hi,

Please find attached my patch for fix port statistics reset inside
loop in l2fwd example

Thanks,
Harsh Raj Singh

--000000000000e93e28064e4aa37f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-examples-l2fwd-fix-port-statistics-reset-inside-loop.patch"
Content-Disposition: attachment; 
	filename="0001-examples-l2fwd-fix-port-statistics-reset-inside-loop.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mne4vdqe0>
X-Attachment-Id: f_mne4vdqe0

RnJvbSA4YjJjNTY1MTgwOGIxZWExNGQzYjVlMTM4NmRkZjY3MTUyNzAzY2UxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBoYXJzaHJhajE2OTUgPHNpbmdoaGFyc2hyYWoyMTVAZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDI0IE1hciAyMDI2IDA5OjI4OjU5ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gZXhhbXBsZXMvbDJmd2Q6IGZpeCBwb3J0IHN0YXRpc3RpY3MgcmVzZXQgaW5zaWRlIGxvb3AK
ClRoZSBwb3J0X3N0YXRpc3RpY3Mgc3RydWN0dXJlIHdhcyByZXNldCBpbnNpZGUgdGhlIHBlci1w
b3J0CmluaXRpYWxpemF0aW9uIGxvb3AsIGNhdXNpbmcgcHJldmlvdXNseSBpbml0aWFsaXplZCBz
dGF0aXN0aWNzCnRvIGJlIG92ZXJ3cml0dGVuIG9uIGVhY2ggaXRlcmF0aW9uLgoKTW92ZSB0aGUg
aW5pdGlhbGl6YXRpb24gb3V0c2lkZSB0aGUgbG9vcCB0byBlbnN1cmUgc3RhdGlzdGljcwphcmUg
Y29ycmVjdGx5IG1haW50YWluZWQgZm9yIGFsbCBwb3J0cy4KClNpZ25lZC1vZmYtYnk6IGhhcnNo
cmFqMTY5NSA8c2luZ2hoYXJzaHJhajIxNUBnbWFpbC5jb20+Ci0tLQogZXhhbXBsZXMvbDJmd2Qv
bWFpbi5jIHwgNCArLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZXhhbXBsZXMvbDJmd2QvbWFpbi5jIGIvZXhhbXBsZXMvbDJm
d2QvbWFpbi5jCmluZGV4IDU5ZWEzMTcyYWUuLmM3OTllODc2OGEgMTAwNjQ0Ci0tLSBhL2V4YW1w
bGVzL2wyZndkL21haW4uYworKysgYi9leGFtcGxlcy9sMmZ3ZC9tYWluLmMKQEAgLTc3Myw2ICs3
NzMsNyBAQCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAlpZiAobDJmd2RfcGt0bWJ1Zl9w
b29sID09IE5VTEwpCiAJCXJ0ZV9leGl0KEVYSVRfRkFJTFVSRSwgIkNhbm5vdCBpbml0IG1idWYg
cG9vbFxuIik7CiAJLyogPjggRW5kIG9mIGNyZWF0ZSB0aGUgbWJ1ZiBwb29sLiAqLworCW1lbXNl
dChwb3J0X3N0YXRpc3RpY3MsIDAsIHNpemVvZihwb3J0X3N0YXRpc3RpY3MpKTsKIAogCS8qIElu
aXRpYWxpc2UgZWFjaCBwb3J0ICovCiAJUlRFX0VUSF9GT1JFQUNIX0RFVihwb3J0aWQpIHsKQEAg
LTg4OSw5ICs4OTAsNiBAQCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJcHJpbnRmKCJQ
b3J0ICV1LCBNQUMgYWRkcmVzczogIiBSVEVfRVRIRVJfQUREUl9QUlRfRk1UICJcblxuIiwKIAkJ
CXBvcnRpZCwKIAkJCVJURV9FVEhFUl9BRERSX0JZVEVTKCZsMmZ3ZF9wb3J0c19ldGhfYWRkcltw
b3J0aWRdKSk7Ci0KLQkJLyogaW5pdGlhbGl6ZSBwb3J0IHN0YXRzICovCi0JCW1lbXNldCgmcG9y
dF9zdGF0aXN0aWNzLCAwLCBzaXplb2YocG9ydF9zdGF0aXN0aWNzKSk7CiAJfQogCiAJaWYgKCFu
Yl9wb3J0c19hdmFpbGFibGUpIHsKLS0gCjIuNDMuMAoK
--000000000000e93e28064e4aa37f--
