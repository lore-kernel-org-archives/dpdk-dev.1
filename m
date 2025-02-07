Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938D7C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 11:03:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B557142798;
	Fri,  7 Feb 2025 12:03:52 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 6EF8A40DFD
 for <dev@dpdk.org>; Fri,  7 Feb 2025 12:03:51 +0100 (CET)
Received: from outbound.mail.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 mx-outbound12-227.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 07 Feb 2025 11:03:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm2UcOEZnalfRWZt3SnwHY3rUx1pHP6kJ4cQ2Fq1kRA7EcPtThnBa0X4BddZMtS3XlSFG8tmTYXaLq3yhBgc3XpB8SrckVg5awCclsL/aoqBNP9rCuDmSAMyfPYN5ECYvCl7qBtJwlPgwb8mto1LFByf1/sEXHD8t6AbznBnIbrY/jlKSIUhC1/o+izX24Uuvq0QFrzUIuyUMkDdbdf8afT/5j78KMxfAY5PfH1iw6hMC4iMN42PkChPm5JX/14+8PvK0b7eCO9WRRmqIb9UgPfteuL7KF9Gx16ihd1QjIL6dv600XjoVxEP3MfX1VqWsMRBAjgiKl0EzX1V3s49ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/piDO3f2eBpzPuUjI54PAO3wBBODlM1JdVEhA0bVAA=;
 b=sU+BQuBEcza1FeWXsVVr7LdcV/g8OgoBwWMwwR7HI4TDZ/aSSqg0E7TI183oI3dTWBCnE9h2V4ITn6mpXWlwDJmrKuTZJMAK4AKxgn8OTTs7mdhvEuObN+D/TXTiaoCNV2oKZtwVGx6AbBjlU+SuZ7p1vqr2Iw5hzjkVqaGz8+PuEtvFTO4FSv62/sxNkoVFWjLIsXkQjjwHSpDdFiFiprJ+a9jLv8uEHFyx91nNaYJ154LXIR/Y/8syn6qjmiyIXdME8hI6xdh5LZqJ+XQguJvyDrZOpqjH1vu4w8Ae/PcEgI/2fgm0KdVW7cENPqil9KH3+2NdbC+AqOyeaOGHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/piDO3f2eBpzPuUjI54PAO3wBBODlM1JdVEhA0bVAA=;
 b=nwFW/NsBOQNiH9uxJ9OT97g7x6CnAJXevTOvPwz4WyxZHeckWGSS5nUkGQlG4oLsHxaFiN1u3UTKXiRVA2kCrmPYDj/APu+fGZIyMHCQkfDEWNav9YZsMUBldVTwFIp7CnsuREQhggC8xRsdYo8AW8m+8hUksJlUgq6B/69mi8E=
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a9::5)
 by AS8P190MB1254.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Fri, 7 Feb
 2025 11:03:48 +0000
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3]) by VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3%5]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 11:03:48 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Mykola Kostenok <mko-plv@napatech.com>,
 Christian Koue Muf <ckm@napatech.com>
Subject: Re: [PATCH v2 00/34] net/ntnic: bugfixes and refactoring
Thread-Topic: [PATCH v2 00/34] net/ntnic: bugfixes and refactoring
Thread-Index: AQHbd7siiBWIl0LYuUSGlKiyAg1HVLM47PqAgAK0CgM=
Date: Fri, 7 Feb 2025 11:03:35 +0000
Message-ID: <VE1P190MB08304F216D411A750E916BFE80F12@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
 <20250205085137.10921d3d@hermes.local>
In-Reply-To: <20250205085137.10921d3d@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P190MB0830:EE_|AS8P190MB1254:EE_
x-ms-office365-filtering-correlation-id: d6f5c668-837f-4c86-5c18-08dd476718ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NAG5M8msfcAz12l0ZRSqd8fwz3AUjkXR/6NpqY+HZ1kRPuF4x+6AUrP2rq0m?=
 =?us-ascii?Q?Femzu+gRkfOZtEufNYasPtWnfVuZGusho22c4DEs1KpfxA1yF1KqNiCwwMT5?=
 =?us-ascii?Q?nFAN/4/AKgv/nqMi7V3IrTlJOLD78/8a2SrncSaTyjE8AKpACWkR/9dHOKjk?=
 =?us-ascii?Q?6Rkz+mQnLgsmsirRkz02ZJ3aoIV1EiS2p/JN1a6ViOeUoccxabFEPnALKr2K?=
 =?us-ascii?Q?uMpqIh63Gjl1UbMefsvt7ruUMcUbTuX+AvdFvvO6FfJ3v4zXlbfP5a+VfJqn?=
 =?us-ascii?Q?i+X9EwU7D/X6iet5Ixeu4wVp74+cYHha3yy+M+5HzMNgrThRzPq8fcepxRCo?=
 =?us-ascii?Q?4e1Kh096DWw63rvqxntpbv4ekP3kjn2U/z8YJDPHkT0s0WuoK0UA8nfA/q/3?=
 =?us-ascii?Q?btaJ0UDUMnKCihjCV/neN4NCJvEKCL3WndbVfza1UWAa5pCsz4hePuPrnYl8?=
 =?us-ascii?Q?4XI88/gq3F3eO9MVY6Dy0gpKGi2hx0G0J34gz+gOv+/5Ryk1TEsPQsyOfjpJ?=
 =?us-ascii?Q?Vqseymcwo3IZwGfckwOApxPKJEjfp4UqqA9KZ5Gs5fdkzmv9m9LketVtfTHn?=
 =?us-ascii?Q?s6qY4vreqiJl9pkBW63kTyJ1WrXGuSDBDwQ0CBv++1Q6yxKw1AcBtmwpwj1T?=
 =?us-ascii?Q?XssMlDQVXsuquw8K2WBCj2V7VQ+sL5x3k4Rr/myA6raIrQ/ZGwX9lClKAyv0?=
 =?us-ascii?Q?+BaAWnVz4Q+t9pb7AaRIDG7rpFt2DrlYT46O4ygXKf7RZ2GBQFJDAdKaZIsg?=
 =?us-ascii?Q?7xhyD/jlReJIkzNIA5zc7yA8lijkZ8RmCqkS2GDLyGhdVorbXyBhQoupW8aq?=
 =?us-ascii?Q?knF96+JutJqXsEftKPIJWPhyUPeicAOMWkKzrnMYk+CxxV1XfNJz1YXXgSk1?=
 =?us-ascii?Q?ZvU1+yeWJRUlQFaTjv4C1erBaozazTbqxYIna/61InbuX/rw5enA2VJWBMmD?=
 =?us-ascii?Q?sA2T78l7+WlEpdlLp99I0Wc49ReFRBJm96Jxztme/N5NSt9cq/C5ln6+GKFa?=
 =?us-ascii?Q?OreaE9DU8mea73kudI3fcxRpRpJ+W1xDxqHdsGBLGYP6hPG+aSy61o96lizf?=
 =?us-ascii?Q?U9dpqH9fVZ/15LLhZk/9KZ9ZHRMz0TeR/pn+Qs53OdVOFQq0VmAwCOjbTOtJ?=
 =?us-ascii?Q?077GQTJLRGUa2vJj+/yMTJKhzq50vTosEMu7l3tFr7rsyfpndUX7RZWMR3X0?=
 =?us-ascii?Q?feAc/euOdoyae275mgpoMC0H7FtUwdneUob6bHH6V90gxTQcChkpIQt2zq95?=
 =?us-ascii?Q?6CDojpDIpsznY+F62SaPzq8DO48T1+qyv2j+0qLk0fxibaNrQZjfkZ0p5bCF?=
 =?us-ascii?Q?UprvHRRnMAGnMlPd5p+uuQmdqLEjsIduWm8AFD5KbPdSvhxGiD1QMnAS3hAV?=
 =?us-ascii?Q?IsjBg5gOYSjuv9sruS9mRoIQqjfH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1P190MB0830.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nO9yL9cg2BnvWu5RoHKHm0uPMfGVqpAYdGjOPAMEhd+JgFf64zM5+EEivIjL?=
 =?us-ascii?Q?zHjCgmpDZaJtbiebBirvHdM+TZss8MQTbRB2zP9OW3zexqsAku3nDoL805CV?=
 =?us-ascii?Q?ZPvospXv3+rlfWFmpbwqSywPGBWqZWvCkM5YGS6VKmDe4cv/0al02lTy7AoW?=
 =?us-ascii?Q?OoIRAAiOJP6lLCV1Ao5ufbu39aKiNySNh0Bz0VzKowjeg1hBTfJ9OwwyqM2M?=
 =?us-ascii?Q?waPMytSaFIXkpc1jaHo2g2lQVTBBadWsLaZDJup84s9vgGbkJOZOCPik35VD?=
 =?us-ascii?Q?Us4Q+D0MUxzhKxk8zNNmsRQQguIf8rnaRSlyoTecJyEI/i1JkRGHzzYjPE8f?=
 =?us-ascii?Q?qu0UDhEgcyexh1Sdn0Sr2O9w2pIHhXz6oAAR5ei33r6ZTX3P7lLBkwB3txf2?=
 =?us-ascii?Q?8CXHPFs6Vfmy6E8EloF9BcuhoGG6v+cTLuPPSU0d7oHm/GuXY6NrT6/druMu?=
 =?us-ascii?Q?OoiP8Z3aVY2KvK4YBTeltfMooTo+BMWFMUp5cJ7JRFYvV2AkFM+vTQQzg3bu?=
 =?us-ascii?Q?FRS9fJZsI145v1NOowdsty1au1GYmgYWydwSFPfh0irv0VPEFryYfPfpegQ7?=
 =?us-ascii?Q?wMAix/y+TWdURL06FIBRUSbqjKcpSCfMwPvWGodpGTnGBwVN4MXRiqL9+Wtt?=
 =?us-ascii?Q?r0HVloH+eE8d1/OZVZFtAa6gkyUyGnuMfuADu7S6DMftlq9VVYyqZ1nHrYaA?=
 =?us-ascii?Q?bfpgRp2dDHCxUb1gJi6/dDefSKFj0lUXcjhNDZ4rmuTAkU7Au8Qbh1MS803r?=
 =?us-ascii?Q?TACGlANAgvILt7Di0jd5VryWRQqMylmGBmyo+3AvgMa87ME7XBFz8X3egfGl?=
 =?us-ascii?Q?HsssKAasdmLTshBF469AVWZLHgLSIJiZzBLZUFVoCF6AOL8DFWlyUifcsYwo?=
 =?us-ascii?Q?9TBj1ZGL/Wy+6W7H6beWAF8NcnzydBEBj8Y+kmYlBeDVJoCYt9NZLUc8Vblc?=
 =?us-ascii?Q?edn18geGZXVVEOw8QWDHLuyBDDSBOCONXFXhEq6PWhSPlHTb4Hui/gqAgoFa?=
 =?us-ascii?Q?C7CM/FCfrv1GPs9bfE89wy+bRZofrs6ci1ayAjp8fOQFX1/GOptHgWpUSMlD?=
 =?us-ascii?Q?mxfNe/rPvlVghmk1Iaz4PseTTWWQdqOumKYTdqASm146NOfoBISJ/xcqVJzP?=
 =?us-ascii?Q?zznMgDzgJCcd7s6NbLC56PzBRUMhdHDpmCXyZvGFDulLUNY88j0ojk4d2aE0?=
 =?us-ascii?Q?kxLBv3x6xq6HW/M4TcvfRv2oNB8Tp1ewpLDBdS9ljbyFgCTanlrmvXe/2pyy?=
 =?us-ascii?Q?DY6gkJXl6mxFP9j2EQB7orxI8wXFaCukh6ISZm5Zsh7u+xnHXPe4nFJf7jbC?=
 =?us-ascii?Q?4glbdlFB8IhnqeVcvytO4WondH+qz/yZwUt6ngRqYXmKcmLz4S43y5+f4ud9?=
 =?us-ascii?Q?LVYR/Jxr8T6ruY7WtntpuuBv4UBZbwcS3VefAUcpBK2iYEWtC2AwKiZBD/fy?=
 =?us-ascii?Q?R6GrDP+lpLPOmfKlbdG8i0QL52XVj8bPQshKCFLMdSqQKW1vXXb9p9y3A6ip?=
 =?us-ascii?Q?HlukACwleTO6jh2P09el7biZPLtDvIqJGPw1ZmVO3g7ym+2mIWRX0lJn4kEO?=
 =?us-ascii?Q?yxRoKs4kMZ9niFsYHPKKXGrFAWY/h1+3jQPT1CNH?=
Content-Type: multipart/alternative;
 boundary="_000_VE1P190MB08304F216D411A750E916BFE80F12VE1P190MB0830EURP_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h3qbmWP4FV3Va+xCVsVvv+vp5yiC9t04MaXJvr/L4UV01mQHPJXPP4LwdxLE+WOUnysTwhiqmvrZlBQbfPjQlmuGQIpfLNj/euXVoG933pYcDyxnyfEHw+IUcnW2K2tBUr0YbfDe9zg1Ynho14q/SvYzy/ScdfmgzBGIEJOjywe32rRz+GIbol+4+R4zal75h/ay0meTA4CaG/PWXq0P+m2aHhqRS4OjOJUfY0TO/kQXM+ZUDZbST1cfboP9EjGofGxXYOLl4hzSp3/OFe/YZNsiDO4/gfDn7fzHz7wG/6sq14imEwptc7AZilYn1jssEYzmlq9pu/MOJu/KGH6UHoPlwKDfzNqRBc3OYtYsyazQjbwMWtv15iIzGEZuwN6RJKiW2+Lp2DjamLt1KpUTccQButXLol/jqU1QS1GLFVA1K2l07GP1Kfz37HvgmQdu698fqajK0O2Hh+mPnFn9dPCrwxEiTALGAZIstzyxqwI+4iQNtJIBCgzySRqsxISzAR9T74EesFez1nT+JsZRiZJu5giWHocL0YDQckTImKN2z5fLrtLZTkj8Ejw8GiS7KL+R0P1wt4A8ZmLdEKYz5SSn5EHjChkdJa4M3KCvjZJZfxocr1JEcGhw94GWlkohznPHnuJIslhiLOgdZlZr/Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f5c668-837f-4c86-5c18-08dd476718ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 11:03:48.3019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+auPSiXEu10CaF0s2LgFiCcaIMSrYqCDU55HbtFHt9rIwtNgA/Xf6jjdTIXVxgb/2rmzjHTk7WKBs90VkhcSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1254
X-BESS-ID: 1738926230-303299-7578-5467-1
X-BESS-VER: 2019.1_20250205.2128
X-BESS-Apparent-Source-IP: 104.47.18.107
X-BESS-Parts: H4sIAAAAAAACAzXLuw7CMAyF4Xfx3MG3xnZfBTEkTlEXxEAGJNR3J0NZjn4d6b
 t9Yf8M2GDMXeD1ho2QyqxjnoIrcRWJmtQN09WImj+KNdsxGc7l74/xvLxiyOW5KVOsmT
 2CUVyLOkc1E3XtxeG8/wAfEyZmgQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262351 [from 
 cloudscan16-115.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=HTML_MESSAGE, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

--_000_VE1P190MB08304F216D411A750E916BFE80F12VE1P190MB0830EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Feb 2025 11:45:09 +0100
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This patch set addresses fixing issues in the ntnic PMD driver.
>
> Changes in this patch:
>
> The issues detected by the Coverity Scan tool.
> The problems that were detected by the internal tests.
> Fix for Bug 1622: ntnic: using signals and threads:
> https://linkprotect.cudasvc.com/url?a=3Dhttps%3a%2f%2fbugs.dpdk.org%2fsho=
w_bug.cgi%3fid%3d1622&c=3DE,1,6udE5Jl1KN1y6YarjUq8xAU2C_RnMxvCsO4FC_7QGgRwC=
OMRCfX-0jEcl4wPapW-A2poKdj_W5XNKd_SMg4ohWp5E3FgSkpTr8VsSWWoOlne_dqw77o,&typ=
o=3D1.
>   The handling of signals within the PMD driver was removed.
>   For manipulation with all threads dedicated EAL API
>     (rte_thread_create_internal_control) is used.
>   Product by design requires usage of threads inside PMD driver.

Do any of these patches need to be backported to stable versions of DPDK?

Hi Stephen,

We do not need to backport these patches to the stable version.
Please keep them only for the latest DPDK.

Thanks,
Serhii


--_000_VE1P190MB08304F216D411A750E916BFE80F12VE1P190MB0830EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-UA" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:11.0pt">On Wed,&nbsp; 5 Feb 2025 11:45:09 +0100<br>
Serhii Iliushyk &lt;sil-plv@napatech.com&gt; wrote:<br>
<br>
&gt; This patch set addresses fixing issues in the ntnic PMD driver.<br>
&gt; <br>
&gt; Changes in this patch:<br>
&gt; <br>
&gt; The issues detected by the Coverity Scan tool.<br>
&gt; The problems that were detected by the internal tests.<br>
&gt; Fix for Bug 1622: ntnic: using signals and threads:<br>
&gt; </span><a href=3D"https://linkprotect.cudasvc.com/url?a=3Dhttps%3a%2f%=
2fbugs.dpdk.org%2fshow_bug.cgi%3fid%3d1622&amp;c=3DE,1,6udE5Jl1KN1y6YarjUq8=
xAU2C_RnMxvCsO4FC_7QGgRwCOMRCfX-0jEcl4wPapW-A2poKdj_W5XNKd_SMg4ohWp5E3FgSkp=
Tr8VsSWWoOlne_dqw77o,&amp;typo=3D1"><span style=3D"font-size:11.0pt">https:=
//linkprotect.cudasvc.com/url?a=3Dhttps%3a%2f%2fbugs.dpdk.org%2fshow_bug.cg=
i%3fid%3d1622&amp;c=3DE,1,6udE5Jl1KN1y6YarjUq8xAU2C_RnMxvCsO4FC_7QGgRwCOMRC=
fX-0jEcl4wPapW-A2poKdj_W5XNKd_SMg4ohWp5E3FgSkpTr8VsSWWoOlne_dqw77o,&amp;typ=
o=3D1</span></a><span style=3D"font-size:11.0pt">.<br>
&gt;&nbsp;&nbsp; The handling of signals within the PMD driver was removed.=
<br>
&gt;&nbsp;&nbsp; For manipulation with all threads dedicated EAL API<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; (rte_thread_create_internal_control) is used.<=
br>
&gt;&nbsp;&nbsp; Product by design requires usage of threads inside PMD dri=
ver.<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:11.0pt">Do any of these patches need to be backported to stable versions =
of DPDK?</span><span lang=3D"UK" style=3D"font-size:11.0pt"><o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"UK" style=3D"font-size:11.0pt"><o:p>&n=
bsp;</o:p></span></p>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">Hi Stephen,&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">&nbsp;&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">We do not need to backport these patches to the stab=
le version.&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">Please keep them only for the latest DPDK.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">Serhii</span><span lang=3D"UK" style=3D"font-size:11=
.0pt;mso-fareast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"UK" style=3D"font-size:11.0pt"><o:p>&n=
bsp;</o:p></span></p>
</div>
</body>
</html>

--_000_VE1P190MB08304F216D411A750E916BFE80F12VE1P190MB0830EURP_--
