Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C781CE94121
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 14:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5058E402D8;
	Tue, 30 Dec 2025 15:05:36 +0100 (CET)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 1878340267
 for <dev@dpdk.org>; Tue, 30 Dec 2025 15:05:35 +0100 (CET)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-88fdac49a85so71712636d6.0
 for <dev@dpdk.org>; Tue, 30 Dec 2025 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767103534; x=1767708334; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zOy61PCDznctU2No1NbrzB+ShqI0z1AvT2QgIdPEXUg=;
 b=a0hd92EGytqnBMoxdBPmRTT0nDZmnFmZ3E8UDVTVzrrgDJFVp6qn9x/bIxahpi/bDM
 274kIJEPhXTCaDzgTZl6LoEoeFkY2JZnbnFPzR47E1POv25L1md+deRP6TYEaUvFUmXr
 8kRAhom+sxsjkXtsSyAGIVoPAw/oaYvHpjCzeOSeeJyVJynYolknhyMQersbrleS26VA
 jkX9OSmAp9Aryk5pK567V2s05ZEXqIOmCoAwrtqx29OAnlM3Yj31RuiLDjGjbVi0t62A
 M4vFfGGq3CVE2jgScqOCTc2KWlLN509PLNShF9cwGTLuE6IaIKloW2h83UNOA24lx5Hc
 BChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767103534; x=1767708334;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zOy61PCDznctU2No1NbrzB+ShqI0z1AvT2QgIdPEXUg=;
 b=LfjQTBNC4xpku5BGcpDwJJgTq88NmNGIxSkqtR5m9q2FL9Z0lG0d4S6yaUCit+dOuN
 c+Ltd2aXBr7I1TaYHGuD/M9U6E0ilZVj9mSISW5lwHCLuYeSN08UWvQaHB1jR977FBK6
 u7drTfChcU6LtwQlWGLkex8mN9pOUumbX0nv2NhxaX/yRXPESYmoNf9w3aFvtFcI3zXJ
 N1G9P6nroY6y/ea6d3NnZ62+AhbBoznwzl2km4h3TdjESdywhgW0kMlN1uHLU60eRExW
 mmH3Z6gFhGaThLkNeEYVVZgJvZ8qxE4Zaj6GMlozFuqjiglqwMoSqfzd9J4QHDC4mxkT
 Hb5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW07vlqhjQEdaHP0H0k+DGO3NHxmOKPMjQ+bxBFRZQbJEie5DhoERjC0AI1jkgTRG790hQ=@dpdk.org
X-Gm-Message-State: AOJu0YySEGmpw26w0h/QuE/VkCu6fL9i+zN27YrR8FBYWoRQttr1yElk
 krbVzpD545eLrGZTAAoSTA+yhp7nkLS0p8oYBkgdZiy/R5xWTWUTOp56q/Sh2jpnbrKPPrU4p5W
 BUk32veH4xTflgd34dZL2//O0HTr2O0A=
X-Gm-Gg: AY/fxX4Qx1F+EwWxJJT6QHVTXhboJeZiruFV/RjLrLK+9IqD2NRrLJ+Zi8mwWkTFZGz
 mQJSoIyUN+jxxmGM+Mis3seSrGIN6BEeZuMh5aPOkHsjW6O+4/s0s0EBzrMq8hz9XJ9CV0Ja4LC
 ab7AeOlYTNVTSoMwF9m1QO4eQHESZyDgl1y7YMCdkOZtg7n6aK/lcYTsDP+uF/HSYDghtNiDsWW
 OES+BpWnbBwEkshqcUPi+Db+dHSILwLc3vlgKAvS3+pSHDPuAxjaIIU0xlaowpgW0MGwCJT
X-Google-Smtp-Source: AGHT+IGuN1pnBWQSjfpChoxR3Q2edmksaKeYPqtJDwWpsQcSnljCQyMIIASnJU6Wvlb+ExZ5KfXnKhsMIAOJiqNHg2k=
X-Received: by 2002:a05:6214:5c03:b0:88f:fcac:e9c6 with SMTP id
 6a1803df08f44-88ffcaceac5mr253476776d6.50.1767103533567; Tue, 30 Dec 2025
 06:05:33 -0800 (PST)
MIME-Version: 1.0
From: coolwilled <coolwilled@gmail.com>
Date: Tue, 30 Dec 2025 22:05:22 +0800
X-Gm-Features: AQt7F2qzCnS7fcik9_aE7UkC6XC93oYOBSb3dzmI4qGPhTCEggnwtqcxhGAcRdI
Message-ID: <CAL2ZP-Any0B5btH4b5deqYytJrD-w+x_utS6KQ2KZase4d3MWQ@mail.gmail.com>
Subject: Is it a Bug? DPAA_SEC-test_cryptodev : output packet length is wrong !
To: Hemant Agrawal <hemant.agrawal@nxp.com>, sachin.saxena@oss.nxp.com,
 dev@dpdk.org, users@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Content-Type: multipart/alternative; boundary="00000000000066510006472bda53"
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

--00000000000066510006472bda53
Content-Type: text/plain; charset="UTF-8"

Hi,
I run command "cryptodev_dpaa_sec_autotest" in app/test/test_cryptodev.c in
DPDK v25.11. The output mbuf->pkt_len is wrong in the case :
TEST_PDCP_COUNT(uplane_encap_with_integrity(18, UPLINK, SNOW_ENC,
AES_AUTH));
from test_PDCP_PROTO_uplane_encap_all()
from test_PDCP_PROTO_all().
In this case,  in test_pdcp_proto(), the output
ut_params->ibuf->data_len/pkt_len = 73.
The pkt_len is wrong, it should be 71.

Thanks a lot !

--00000000000066510006472bda53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I run command &quot;cryptodev_dpaa_sec_=
autotest&quot; in app/test/test_cryptodev.c in DPDK v25.11. The output mbuf=
-&gt;pkt_len is wrong in the case :</div><div>TEST_PDCP_COUNT(uplane_encap_=
with_integrity(18, UPLINK, SNOW_ENC, AES_AUTH));=C2=A0</div><div>from=C2=A0=
test_PDCP_PROTO_uplane_encap_all()</div><div>from test_PDCP_PROTO_all().</d=
iv><div>In this case,=C2=A0 in test_pdcp_proto(), the output ut_params-&gt;=
ibuf-&gt;data_len/pkt_len =3D 73.</div><div>The pkt_len is wrong, it should=
 be 71.</div><div><br></div><div>Thanks a lot !</div><div><br></div><div><b=
r></div></div>

--00000000000066510006472bda53--
