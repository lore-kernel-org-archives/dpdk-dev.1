Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915B8C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 09:20:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D92E14067C;
	Mon,  6 Jul 2026 11:20:45 +0200 (CEST)
Received: from sonic302-21.consmr.mail.ir2.yahoo.com
 (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
 by mails.dpdk.org (Postfix) with ESMTP id 5B7224026F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 21:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.se; s=s2048;
 t=1783106564; bh=sfbvgwoim9h39DgI5Ioankehx3NTtTR17zYAdvLY7vI=;
 h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To;
 b=dkG2xp4mXejLIMjV4OtQMRvM/D9Q+bwJ9D6+UuEF3+JQJMHyEt5CsWkP1fO9PdpMp/9xbmiE9lclDSYmaHxp69Rf3Ty7tQOBm6g3cYudA9Jc3cHEnecWLJE1i4mFUnEtZ2UCvequ1VPwfotXfzF9q77bZvLZJziDEAH3nND5wyTCgHPzZwlsTbc35MiZDRrb+MMBnaIhTLAH6niSBzYBxfkDC8qXh0QM4zaW9rLEFRJUxPTwa8CeyEYK5kI66OdmCsLn1qYYkbONkpTp6cl4lt+S91SqeGdHlIJed2rAn/uHFP4ZnfJJQjNqP+Qar69oU20IA1i3efv3cjzCZkNelg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783106564; bh=do6xrF59nbxf3N0oJtbVxUCR5TMQR9GF9/mDPWKS9uh=;
 h=X-Sonic-MF:Date:To:From:Subject:From:Subject;
 b=F2CYN/9L1q8Sw80uoWVwANDQVNmLuq3r0Bet30V5q4cScsSFRNE/kAGNVtJ5rutYm+hnKMtgp5qrAs2Qq+Rkrvs42Rq1AoRIlh24k03HV1lfbGaf7pDHj9prUSWAlNvHgSWEFkbGHkEdUo9GOUcWIlfqC9qilZWbw1BEeP15Cj4KS9k5dogLrJVADs8ciOzRbYsuSLVIxhl9FTHNFD5GEJD+oiOuHZpOVvdknI/8JPwPIv5HjsZ6lBhg3NiA5Pqh0eacHiwmCSRF4gOgX3y1YOd8BEZLdbzfM4JTbGHCAh/iP+yJwuGhKL3RjYlei3xufAKGu98G5V9XQOjTBl+Giw==
X-YMail-OSG: 63Ky7MoVM1kCCHVmo_hCd0XFIRuCunM3bJM7VSIi3XIgPSgKk4cef7c2K2gdSZG
 0i1fiOqoXccxU_d6j9daWhn_x6l1y9RDW9uMAjOX3Q3w4l_yw0_sMjZ6DA8wxRs1lraZN7yz4k9t
 MJwDqVME_rMnStX5OQ4mgRa9nwAGPRd6haNbI6hGYlLzkRpfvDX6frpi1lbCu.Q7g4pZf3OBXCkB
 gtS6Wux3x2iMWMcjfAFjELBcZ_PjuHXe4i01prW1odWjn0UdRD0SIawrkZuzOevfw3jBW7yiAOHr
 BmzSRv4AKGudsuqbGYiKbgMgefrz.Uy2MxV4b7DB5l7LV8Yw2gZZrA0NPobakf.6D40B4euBT99K
 lub.EPWFnKkVds8FXRUq2LHySj6OCKVIfAXc4qVQ6URkIbXHuHMrmwJu46E4wvempd2lMIrTlnx3
 wI5THc37u1I.5E303EuAjEoZRfP9LpQzHv5otc7tFF4QBD5vvcSv.AJcJrEBMX4qKE3LCUlbiOeI
 UYVBRJE55w6RAeLa1FXgaTmKg5_fCRN8fRKxtEVkJTBtC7moZvBgE1bxhn3..nKKpvV.Z3jSeMLQ
 LYKlAuT34G5kvel3DloO5PIax79uIQIsrxJYKXWsVCBs0gNB243CyoWSGBOamu_0XwvhITkascsD
 6PyC54fM7f8zhK3RNudzDbFRnIxlXALaGeQJLZlDy_Z201lcA9nO35vgg1iLdt1nnX4T5arvSxFu
 1SVgcfu9ljNxXTw9KSTdOH7RVDNK71UjjCwdrV7afd8DUM1lLPH1_TwA3u2lvyES4WWAVlKj1Vyk
 l1PiL8tM8N3NbFnm3dCGqOaoeOOFMEssyDvrw7hAh9QTBNJugMuIFu2ndhM_DxGcSIAo0bHX7Z7I
 EMDn3eefLzIkXqbYDaGyMh6l8utLG2yCMyeVeAwse5w52EmfCTu1MTeCcL6j_pj42ByfSE2lpKFi
 tqy1vFFPPTGGvLjfKdwmO7LVOmWAh49nE4D.HpkaSt2kf9i38xybMxBaEYmdSrVMlfCI9BlqDz_5
 si9Gg3BRNT01ZoZ6zcLYj1MOmx7r5hk1PaeO2gU3Q2GTC8rDZTTCQneLnhBP6M2ISRmGy22RcEWi
 Q4Ki2yC9PhmBSaIS8NBPT61HcM.rbjqev0G6thR9NdX09Uvi6vMhql4nfXDTEWHd1RxxyKnKyR3m
 AF2S7vcecCAGHYZ1r2Tk5n8jvd05NLQ4oKvQ_ybBzMYkK5LE5QzO5efzL__qPoXw5r8qILm_HUuO
 W7_RhIh74Ig_AY1h83pcpPonvklyxCyN5BsjjSual_4T98OWwCAE8IXKLHYjNBR8.17PVzMM68nu
 b2ptnPeHby7x1di5784jE21p.iJGQ3dY_L_tyEUeB1EZ_juwwpXuweQcXWjhF0m8JzFoEn2pAUT5
 yNvekqOh__nz8ePM12QCQJ2cOJji.QQWJ2o3THMpDrCRi7iYxNVDCPMSWyukhxdtSrgVsEURysma
 g.qk2ctFzCnL6cGbZNdqcQBhejRLvSaPiMWszE6KeF1vLohFmmjWCV5HouPUAhrIpff7MBcGO69e
 dNrekJC_4l.CDrP9HvF0feN6HYZTbVp0F77sOpMss11dMf30MtRSFA.9ZqP2cD.RqyBmbaCgitpm
 Xgw1.OFgiPoROyC.2.HTvrMMRjrUQhiwmze8d4LxFldx0UziFLaTlCjfv6AOU0TYej_j9sabcz49
 HBPM6KKhiEQKb_bZGnbUk52UrpyPsuf4Urmxx1PVSB3Ax7AJz6H5uptmSdaEz.B3gY0UMN64kgWr
 yu3CwOow9Af9Ur.ZD88p5RK_m_x8kCtly8Q6dd4F1YjC3VtwXvIW6bgKZ946_TbH5HCjxWEO0qI1
 STN6nkedkIvW56yit4OQPkop8BngF8MFGPfvZA_2QGCvh1.03MNhi5Q1c8jgW3Msesmt0kMhUdQu
 bO1AvaIftq8UK8d9uj6Q4i5MLhivaSxUJYwK6DtwkwNb50cWKESPX9uqZjrNdv_JDdINJYOIVdtz
 ZimE45ff3UYNz1SolHVqGZco832zpeeRBdJr2aBcE5zrX4fZknwR1oovLC3lMSGTQzfQqjh.Y.0e
 JsHSXTWiYKS8p1ofBfIJPQwgnjStmKMxSUtzB5nJ6FvjYthYUIz.xHKVVTA9trhsH.YwXFTgYZQs
 vpJg7k._L_vPBTBPcH2BToGFS80133_Fkz6Ig6g0oeFJ3Sp6UmfdsvydyHQY9mVBBMPbjajtAUFr
 XMSKJOA4Oq.3DZp2x744AfC4rBCh0rPZaJmVnZLTcvpEHmN1jgympCQRmtrb_DIve9P.1_6Wj_Q-
 -
X-Sonic-MF: <anders.franzen@yahoo.se>
X-Sonic-ID: d43bec42-08a2-4b8a-a79f-1d221d4174e5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ir2.yahoo.com with HTTP; Fri, 3 Jul 2026 19:22:44 +0000
Received: by hermes--production-ir2-7b48fcd765-bfwpn (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 4641cd328e20d3b1fcc90d787b282fa0; 
 Fri, 03 Jul 2026 19:22:40 +0000 (UTC)
Content-Type: multipart/alternative;
 boundary="------------qbgPdKluVSNFjpZ89nHEUDbj"
Message-ID: <31c2f2b6-fbdb-4d1c-b6d8-5659e0182f8b@yahoo.se>
Date: Fri, 3 Jul 2026 21:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dev@dpdk.org
Cc: cburdick@nvidia.com
From: Anders Franzen <anders.franzen@yahoo.se>
Subject: Re: [PATCH v4 1/2] eal: support dmabuf
References: <31c2f2b6-fbdb-4d1c-b6d8-5659e0182f8b.ref@yahoo.se>
X-Mailer: WebService/1.1.26086
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Mailman-Approved-At: Mon, 06 Jul 2026 11:20:43 +0200
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

This is a multi-part message in MIME format.
--------------qbgPdKluVSNFjpZ89nHEUDbj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQ2xpZmYgYW5kIEVBTCBNYWludGFpbmVycywNCg0KV2hpbGUgdGVzdGluZyB0aGUgdjQg
cGF0Y2ggc2VyaWVzIGZvciBhIHNpZGUtYnktc2lkZSBDUFUgdnMgR1BVIGxvdy1sYXRlbmN5
DQpmb3J3YXJkaW5nIGNvbXBhcmlzb24gdXNpbmcgRFBESyAyNi4wMywgd2UgdW5jb3ZlcmVk
IGFuIHVuaW50ZW5kZWQgYmFja3dhcmQNCmNvbXBhdGliaWxpdHkgYnJlYWsgaW5zaWRlIHRo
ZSBsZWdhY3kgcnRlX2V4dG1lbV9yZWdpc3RlcigpIHdyYXBwZXIgcGF0aC4NCg0KQ3VycmVu
dGx5LCBsZWdhY3kgYXBwbGljYXRpb25zIGNhbGxpbmcgdGhlIHN0YW5kYXJkIHByaW1pdGl2
ZSBmYWlsIA0KaW1tZWRpYXRlbHkNCm9uIHRoZSBmaXJzdCBwYWdlIGl0ZXJhdGlvbiB3aXRo
IEVJTlZBTC4gVGhlcmUgYXJlIHR3byBkaXN0aW5jdCBpc3N1ZXM6DQoNCjEuIEluIHJ0ZV9l
eG1lbV9yZWdpc3RlciwgdGhlIGxlZ2FjeSB3cmFwcGVyIHJvdXRlcyB0aHJvdWdoDQpydGVf
ZXh0bWVtX3JlZ2lzdGVyX2RtYWJ1ZigpIHBhc3NpbmcgYSBoYXJkY29kZWQgLTEgZm9yIHRo
ZSBmaWxlIA0KZGVzY3JpcHRvci4NCkhvd2V2ZXIsIHJ0ZV9leHRtZW1fcmVnaXN0ZXJfZG1h
YnVmKCkgZW5mb3JjZXMgYSBzdHJpY3QgZ3VhcmQgY2hlY2sgDQpyaWdodCBhdA0KdGhlIGVu
dHJ5IGdhdGU6DQogwqAgwqAgaWYgKGRtYWJ1Zl9mZCA8IDApIHsgcmV0dXJuIC1FSU5WQUw7
IH0NClRoaXMgcmVqZWN0cyBhbGwgbGVnYWN5IENQVSBob3N0IG1lbW9yeSBhbGxvY2F0aW9u
IGNhbGxzLiBUaGUgbGVnYWN5IA0Kd3JhcHBlcg0Kc2hvdWxkIGluc3RlYWQgYnlwYXNzIHRo
ZSBleHBlcmltZW50YWwgZ2F0ZSBhbmQgbWFwIHN0cmFpZ2h0IHRvIHRoZSANCnVuZGVybHlp
bmcNCnN0YXRpYyBleHRtZW1fcmVnaXN0ZXIoKSBjYWxsLg0KDQoyLiBJbsKgbWFsbG9jX2hl
YXBfY3JlYXRlX2V4dGVybmFsX3NlZywNCiDCoFZhcmlhYmxlIFNoYWRvd2luZy9Db3JydXB0
aW9uOiBJbnNpZGUgdGhlIHBhZ2UgaW5pdGlhbGl6YXRpb24gdHJhY2tpbmcgDQpsb29wLA0K
dGhlIG1hc3RlciBsaXN0IGluZGV4IGl0ZXJhdG9yIHZhcmlhYmxlIGlzIGNsb2JiZXJlZCBi
eSB0aGUgc3ViLXBhZ2UgDQpsb29wIGNvdW50ZXIgJ2knLg0KQXMgYSByZXN1bHQ6DQogwqAg
wqAgZWFsX21lbXNlZ19saXN0X3NldF9kbWFidWZfaW5mbyhpLCAtMSwgMCk7DQp0YXJnZXRz
IGEgc3RhbGUgbG9vcCBjb3VudGVyIGluZGV4IGluc3RlYWQgb2YgcHJlc2VydmluZyB0aGUg
YWxsb2NhdGVkIA0KbWFzdGVyIG1lbXNlZyBsaXN0Lg0KVGhpcyBsZWF2ZXMgdGhlIHJlYWwg
c2VnbWVudCBsaXN0IHNpdHRpbmcgYXQgaXRzIHplcm8taW5pdGlhbGl6ZWQgDQpkZWZhdWx0
IChkbWFidWZfZmQ9MCksDQp3aGljaCBwb2lzb25zIHN1YnNlcXVlbnQgZHJpdmVyIGxvb2t1
cHMgKGUuZy4gbWx4NSB0cnlpbmcgdG8gbWFwIA0Kc3RhbmRhcmQgQ1BVIGZyYW1lcw0Kdmlh
IHJlZ19kbWFidWZfbXIgYmVjYXVzZSBmZD0wIG1hdGNoZXMgc3RhbmRhcmQgc3RkaW4gaW5z
dGVhZCBvZiBhIGNsZWFuIA0KLTEpLg0KDQpGaXhpbmcgaXQgcmVxdWlyZXMgY2FjaGluZyAn
aScgaW50byBhIHBlcnNpc3RlbnQgbG9jYWwgdHJhY2tlciB2YXJpYWJsZSANCihlLmcuLCBt
c2xfaWR4KQ0KaW1tZWRpYXRlbHkgZm9sbG93aW5nIHRoZSBzdWNjZXNzZnVsIHJ0ZV9mYmFy
cmF5X2luaXQoKSBibG9jaywgYW5kIA0KcGFzc2luZyB0aGF0DQpjYWNoZWQgdHJhY2tlciB0
byBlYWxfbWVtc2VnX2xpc3Rfc2V0X2RtYWJ1Zl9pbmZvKCkuDQo=
--------------qbgPdKluVSNFjpZ89nHEUDbj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      Hi Cliff and EAL Maintainers,</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      <br>
    </div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      While testing the v4 patch series for a side-by-side CPU vs GPU
      low-latency=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      forwarding comparison using DPDK 26.03, we uncovered an unintended
      backward=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      compatibility break inside the legacy rte_extmem_register()
      wrapper path.</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      <br>
    </div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      Currently, legacy applications calling the standard primitive fail
      immediately=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      on the first page iteration with EINVAL. There are two distinct
      issues:</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      <br>
    </div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      1. In rte_exmem_register, the legacy wrapper routes through=C2=A0</=
div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      rte_extmem_register_dmabuf() passing a hardcoded -1 for the file
      descriptor.=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      However, rte_extmem_register_dmabuf() enforces a strict guard
      check right at=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      the entry gate:</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      =C2=A0 =C2=A0 if (dmabuf_fd &lt; 0) { return -EINVAL; }</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      This rejects all legacy CPU host memory allocation calls. The
      legacy wrapper=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      should instead bypass the experimental gate and map straight to
      the underlying=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      static extmem_register() call.</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      <br>
    </div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">2.
      In=C2=A0malloc_heap_create_external_seg,=C2=A0<br>
      =C2=A0Variable Shadowing/Corruption: Inside the page initialization=

      tracking loop,=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      the master list index iterator variable is clobbered by the
      sub-page loop counter 'i'.</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      As a result:</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      =C2=A0 =C2=A0 eal_memseg_list_set_dmabuf_info(i, -1, 0);</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      targets a stale loop counter index instead of preserving the
      allocated master memseg list.=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      This leaves the real segment list sitting at its zero-initialized
      default (dmabuf_fd=3D0),=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      which poisons subsequent driver lookups (e.g. mlx5 trying to map
      standard CPU frames=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      via reg_dmabuf_mr because fd=3D0 matches standard stdin instead of =
a
      clean -1).</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      <br>
    </div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      Fixing it requires caching 'i' into a persistent local tracker
      variable (e.g., msl_idx)=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      immediately following the successful rte_fbarray_init() block, and
      passing that=C2=A0</div>
    <div class=3D"elementToProof"
style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      cached tracker to eal_memseg_list_set_dmabuf_info().</div>
  </body>
</html>

--------------qbgPdKluVSNFjpZ89nHEUDbj--
