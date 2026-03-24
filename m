Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1BBFF60D9
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 07:38:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F36D3402A9;
	Tue, 31 Mar 2026 09:38:01 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 239814025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 05:23:29 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-439af7d77f0so3587886f8f.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 21:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774326208; cv=none;
 d=google.com; s=arc-20240605;
 b=hzLVSwcGUT9sto5p+d/dU+6D6vU22dk+UAeZur847RmlgemwoBPRvIXbAx/soE/SOy
 FivDBQb5vraoXWRNyZlsJsXqj84yWWulrqXop0dzBS9Wei08ICy2H03K3uRRHGt3B7fB
 gDIjeYjKeBE+CZhnyssaketvvMGHnTwLPtRIwASyj2EzGjx+i3U50VPno3eeeGv98c6+
 kYXNgrQ5Dwr10jdV1g7mXBXgAMqFmFtf6MY/S80qX0lZMWLb10bTAEfTPxfY9XFinkPm
 RwF2F7OUqNN5l2w8oWkzwFvT5Jnlyp+NXVlpL/Hcd7tWDxBsIi0R8rf75j5J7rs4rjgT
 2gOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=lZuaMj8aYJBhpM+GTgjZoqgmILsVA9ikdtZGdBCZtgQ=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=S2toxqRf6zFj7WTvBwnJxbMtiCPvYcIn9iWbICz1kFzt+HHGvKPxtGql0exKDXQcfZ
 R9IKWWZiiqe8qPHsbuw82XdLov/LTG0HiU23Kl1THudiA2crnC2GeaEitl8f3ooF2qQd
 /I68YDIIxeecOztkWpFbcspJNBrVT7OrEMe1/TmMPZYKs2+d5iaUpDS7Ra99csg8SbUL
 WLpJTitbylrnNpNL3IQzWtS6w1cM1W+sfBLsh8CIcYZmmyUkbh2zkypp7BcBRSqphxgY
 WacawmmGtvTLeGcsokZBt38bV8hw4UvfH3rLbVfa9Qwewtbi/kJ7HtB2fuGJjP3mNjwO
 QGEw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774326208; x=1774931008; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lZuaMj8aYJBhpM+GTgjZoqgmILsVA9ikdtZGdBCZtgQ=;
 b=TweIvFmirCNZ4wYd2EGl1OzUEtzlb2R5dkXbz4UDzag4t1q8mpfU3w0CSzrk2CcEfP
 rAi2Mf2TSND6/WZV68MwpEMulDAYbpqBscPTsIrOgxBtovjXV36QwNhjrCRQWBVus5y0
 53FmhdCcFz4q42RFYORrJBuGcjHsDH4XJKzswNwHFyx3NgV2yAqDvaaZG5YGAB2fOO7v
 byDMQlkhgGvzVOL/LOdeRgYlXkiJR3cng/jGpgTHyAvuQ/DhZyo0ho2zPVxvNEoLltZD
 rwn2oXh25donkQsbntj9RML7fp+TaVCq1y2vzEu+bkeszF/1uxjQSrEnNFsOyAShz26l
 Y8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774326208; x=1774931008;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lZuaMj8aYJBhpM+GTgjZoqgmILsVA9ikdtZGdBCZtgQ=;
 b=S/vMkwEv0FNOtgglMXUXDih5IbbkWaSP3YOiJ9jZUnLn8jEFduuIsvWoKMv/soA1Aj
 sY5fY62XwWA+9c3UmQELvBRF+fTYJLoERjvDAjJgAm00Wq5Enrx0ryfC/ODg7+9vAhsY
 4Q1iavXxb2CmEFL9nY26IOVw/Z9cBhVIDFFRXuAp4h7nIcLJxGBJNsPiDujOx5Z4pPD1
 7vLJ2XwWQiyYCLrIqs30cbKvYO6c3cYpjUerF4/rOTLrhp4G4qvlMJAxDFbuwOqexI66
 28l+PTt2HLR1RuQFvoXeMYrhXvOGY7sMDt59oi6gMXS3JGUyLYyxyI+XaYOy9qYegEEC
 gYKw==
X-Gm-Message-State: AOJu0YyDDDHMlq86D7Mm4/QVLYs68/P52kwC8KKWXB+xZCS3XuZWUhrY
 Vef+prAw/qQFX5j9ww6aKB2ESAOSF2jwIlUyM2CpNcWDA8OrvHgw6F0FKJb1/BooQrHgcAfxRxD
 XHdH7wRgDTIFifF2aUxS0x54YIuxz/oa4eg==
X-Gm-Gg: ATEYQzxe8B+UY4Qo06ZdpyHzu7jj5rYuannS5fWgYbSL0rdNcoC/lN5GBUeHFYl58PE
 Nqi5d5halGa/evVs9m+Ybsh7qZAH4sOchLXtQH3yNpxQh8KiekVv0Ls4kJZBqylEiibEh4s1FTz
 dl/nb1ZfzILpwhuK+oBGnWv12kSdHA53KemqnAAzMB6eS09faz2xHdOKCgq4Z/RFN6nne+J54FM
 irB6VHVUdW0v8I5cZDexiO16/9B+uLw9zXrbMFrasXF2ZZdQ+acWE8rnR0dcOyYvY1AsLlmoCMO
 QfK/IlUgGE5ebPUe2HDbkeJ392zwvORnTzqGmb6SjD/eC8arQWLSrOeQhE4cAbLh4l9TtFr0HOo
 rk5s=
X-Received: by 2002:a05:6000:2dc2:b0:43b:4f7d:e085 with SMTP id
 ffacd0b85a97d-43b64262ee3mr22518564f8f.35.1774326208243; Mon, 23 Mar 2026
 21:23:28 -0700 (PDT)
MIME-Version: 1.0
From: Harsh raj Singh <singhharshraj215@gmail.com>
Date: Tue, 24 Mar 2026 09:53:15 +0530
X-Gm-Features: AQROBzCwxlnkjP3Pe5iamtcchOpjKuchYKP2HpOmzAImS90YJ3E7eP1ON3K2VN0
Message-ID: <CAN33txH-7ipPq_LmeML=Zp9ejgat0UOQe9-GM1x6K2jc81Bipw@mail.gmail.com>
Subject: [PATCH] examples/l2fwd: fix port statistics reset inside loop
To: dev@dpdk.org
Content-Type: multipart/mixed; boundary="0000000000005bbf0e064dbd83d5"
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

--0000000000005bbf0e064dbd83d5
Content-Type: text/plain; charset="UTF-8"



--0000000000005bbf0e064dbd83d5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-examples-l2fwd-fix-port-statistics-reset-inside-loop.patch"
Content-Disposition: attachment; 
	filename="0001-examples-l2fwd-fix-port-statistics-reset-inside-loop.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mn43zyh10>
X-Attachment-Id: f_mn43zyh10

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
--0000000000005bbf0e064dbd83d5--
