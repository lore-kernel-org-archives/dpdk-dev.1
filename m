Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72654606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TAiVhTY5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D14A4028B;
	Tue,  3 Nov 2026 04:50:55 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by mails.dpdk.org (Postfix) with ESMTPS id BB13A40278
 for <dev@dpdk.org>; Tue,  3 Nov 2026 04:50:54 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A31jOOr3337246; Tue, 3 Nov 2026 03:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NG2d1d
 3lPJJsVuCAzLVRNyI0m1DBwmSFRmKA5AgkGXI=; b=TAiVhTY5wcKF8LwbYnngrq
 Z8mPO6zWY/YfaKdO72tKoVuJfrohunTxQQPSvvW0KxTU87H8tyDPdtwF/18dV5t+
 Pvmtn2WZ32kkyAVltMCMrssUDhrxgAI/5pSZ0mX7GanSvncuBx/oA1Jx+xOTvayW
 TCy0PoRWb5jP81zwk28AeSPKpDlXySSLPx1BWTkZA2ipcI8s5zs9icgquK8ih7c3
 S3A3WIL2ssZLOcr9UugNEwb0es1I+yAqsANuHWHXPz32BbyyKvG75X8pyD3laO2s
 zgtxgJ1MEriczGllykiMaJNTO17fNlTLZCTqebx31EjY0QW2V7gJvhs66ASdKiGw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd3nuq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 03:50:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A31o2cD623512; Tue, 3 Nov 2026 03:50:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfrj78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 03:50:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A33opjx16319102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Nov 2026 03:50:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C6D95805A;
 Tue,  3 Nov 2026 03:50:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46A2F5803F;
 Tue,  3 Nov 2026 03:50:51 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.61.48.193]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Nov 2026 03:50:51 +0000 (GMT)
Message-ID: <0b24cbfac4116e076947cfcc746d0b855f32a6d8.camel@linux.ibm.com>
Subject: Re: DPDK release candidate 26.11-rc2
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Date: Mon, 02 Nov 2026 21:50:51 -0600
In-Reply-To: <xr97c_w-SU6AD1Rq8Uh_NQ@monjalon.net>
References: <xr97c_w-SU6AD1Rq8Uh_NQ@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bhkTfJ3lt1hl8GEdazUqq2IFXzZU1vU3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAxNCBTYWx0ZWRfXwShsvLuEaG9d
 INKZF6fb6+ipL1pMczmZDl9qmUcVDRBG8GZ3HFsCRn7XXVxuiwAlR3yVtJ1U5f2IptYkvPFQK66
 UxRBs+oVtkoV3nQSopNhNJRdKD5RXDWVKNQzl7E4tNzLahaFyg6N0xdLU1UBQEDVMkd33+Q7AjQ
 IwO49/S3YFyIorPAfxuXYtNh9rvAThNjdkbZJ4WdtdlSfDrop5roo4aa6J6uAKwB59b2q15pLFO
 9+O/9e/Z23lX1ihNGiaOgMA5ofyGIVyMpDHSpe7o+JQIW+iYfC5KnyXFvQyddP6GiLvGNynNVR4
 RuLV5TCjpKRh56Rmi64dXj6CV4c5PNhV4XqThDZ9qi4FITsp8/z+pTlfk731DfRikr3Io8sKvJM
 wl0I3Vky8MjimJkIWFQ5mJecw8dhv0U6UbFwFL1SKu8Hx/a/rtuPZB1x8fOOVdQPczFH9RlHKQ1
 92U2LYPsNBPieV11nxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAxNCBTYWx0ZWRfX/FZ+jVeHUZad
 erOT++L4Z38swhb+iBzy/zN+LN+Dvk92r/1J3kZ+BI0v3tEVGznIcp+HDskQ3fQy9SFWeR0HXM2
 mBdvyvK+ib0AuVxB5xJEV7p+NuSXt+o=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae95a1d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8rWy6zfcAAAA:8
 a=o0H6PxKc5kZCS8mi02EA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: bhkTfJ3lt1hl8GEdazUqq2IFXzZU1vU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030014
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IBM - Power Systems Testing
DPDK v26.11-rc2

* Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
* Basic PF on Mellanox: No issues found
* Performance: TestPMD throughput single core tests
* OS:- RHEL 10.2  kernel: 6.12.0-211.64.1.el10_2.ppc64le
         with gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4)

Systems tested:
  - LPARs on IBM Power11 CHRP IBM, 9105-22A
     NICs:
     - Mellanox Technologies MT4129 Family [ConnectX-7 100 GbE 2-Port]
     - Firmware Version: 28.48.1000 (MT_0000000834)
     - OFED 26.07-0.7.7

Regards,

Riley Fletcher

On Mon, 2026-11-02 at 19:18 +0100, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv26.11-rc2
>=20
> There are 357 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_26_11.html
>=20
> There are many fixes and drivers features, including AMD NTB.
>=20
> Please test and report issues on bugs.dpdk.org.
>=20
> Patches to improve tooling, examples and documentation are welcome
> for the next release candidates.
>=20
> We'll try to close -rc3 and -rc4 in one week each.
>=20
> Thank you everyone
>=20
