Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D868F327A3
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 05:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B63E8402EA;
	Tue, 21 Apr 2026 07:47:54 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by mails.dpdk.org (Postfix) with ESMTP id 25A5C4029B;
 Tue, 21 Apr 2026 07:47:52 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KJh6Cu1651500; Tue, 21 Apr 2026 05:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=flTFKC
 uGi8XxLsOnVzGODe9osOzRPU/JQnA6frdqmVw=; b=rpr/dhedOC3dVlh56l0CGm
 4GnnIxNKhwvveXHcPIbJVIi3jjQlLMX+wY8vHiMDO70e458WY/G1mwQYGGnGcpkd
 pYLUiA5tm8rMHZi9oNIm6/hLJzI2V5KqEHfVPRd1mUQyx7D7STwjLcKmB4HVPVES
 fPyxvPHMQeuqzc9fQ+eFBJlD9FKsfucr4R2tD0dcbnU31qnoMc2wHQ/vPrujiRqq
 ozR96YVSCiEO0KYKEnmEn3Zc+raDcRWYGf5nPu6s577LicLTbNLe17/KjvUHYmmy
 O04Z4nqCzq8n9Fu5YQBE8pW+X+YbQPPRPHre3TzkVNTJXp8o/5EoFd+w1lbF5JTw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k52unm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 05:47:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63L5ZMDC020874;
 Tue, 21 Apr 2026 05:47:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyxy9rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 05:47:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63L5ldV715073998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 05:47:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8497E5804B;
 Tue, 21 Apr 2026 05:47:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62FFF58055;
 Tue, 21 Apr 2026 05:47:38 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.61.154.209]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 05:47:38 +0000 (GMT)
Message-ID: <0ccdfe867dfbd01e6d13017c00465696fafe0d46.camel@linux.ibm.com>
Subject: Re: 25.11.1 patches review and test
From: Riley Fletcher <rileyf@linux.ibm.com>
To: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>, Ali
 Alnubani <alialnu@nvidia.com>, benjamin.walker@intel.com, David Christensen
 <drc@linux.vnet.ibm.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Ian
 Stokes <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, John
 McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, qian.q.xu@intel.com,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>, yuan.peng@intel.com,
 zhaoyan.chen@intel.com, Shani Peretz <shperetz@nvidia.com>
Date: Tue, 21 Apr 2026 00:47:38 -0500
In-Reply-To: <20260402164454.669125-1-ktraynor@redhat.com>
References: <20260402164454.669125-1-ktraynor@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VpqTpToh1ib8sCmNgjnNrYfV-OBhyzU1
X-Proofpoint-ORIG-GUID: VpqTpToh1ib8sCmNgjnNrYfV-OBhyzU1
X-Authority-Analysis: v=2.4 cv=VP7tWdPX c=1 sm=1 tr=0 ts=69e70f7d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=8rWy6zfcAAAA:8
 a=BH5HX-I12twILGoAlYsA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA1NCBTYWx0ZWRfX5seo7RFIx0NE
 6eh3FV7pCc0UgapRL4mxkGmtghMwrlr34qUa/6BU0fBxe6yGvz5I1QIzdB46NXuUK146vAs3IYQ
 mbJE1rHMfV7W8O7NzVDAGpD8xFKjZduboU6KpvnAx+Cj/JtBW93XEzpK4feWbF06zTe8oq/1EWs
 91d/XZqUbWFyEeF/BuuzLlw8X7Vfr6VSAiUhdzI91/Xeokg8ARvQKlhR2fJxDKaw81grlqk98nQ
 OEPK+56MpSdvdstdnuA6um7nbTdtPnFJxF9u2sj8vtI2K5jztR1vVD3pIpO5E7InF4nOXl5Wub0
 d7hZFAtwizd6FW9LaffubcTvTISeUCNuRcTyPCzd2/6GA4Ms8dhLim2T93vhaHqmfuyYukmtO4o
 AtUhtA1Fuk4kDZa68noyTxhXrcvO2JAPcGqsknZWVXYtHOt8whQqKaTBeka/eIuf8+9SZI7hpRk
 0eFjfT+X+WfibkaYVhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210054
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

IBM - Power Systems Testing
DPDK v25.11.1-rc1

* Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
* Basic PF on Mellanox: No issues found
* Performance: TestPMD throughput single core tests
* OS:- RHEL 10.1  kernel: 6.12.0-124.39.1.el10_1.ppc64le
         with gcc version 14.2.1 20250110 (Red Hat 14.2.1-7)

Systems tested:
  - LPARs on IBM Power11 CHRP IBM, 9105-22A
     NICs:
     - Mellanox Technologies MT4129 Family [ConnectX-7 100 GbE 2-Port]
     - Firmware Version: 28.47.1088
     - OFED 26.01-1.0.0

All looks well on our end.

Regards,

Riley Fletcher

On Thu, 2026-04-02 at 17:44 +0100, Kevin Traynor wrote:
> Hi all,
>=20
> Here is a list of patches targeted for stable release 25.11.1.
>=20
> The planned date for the final release is 21st April 2026.
>=20
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release
> notes.
>=20
> A release candidate tarball can be found at:
>=20
> =C2=A0=C2=A0=C2=A0 https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv25.11.1=
-rc1
>=20
> These patches are located at branch 25.11 of dpdk-stable repo:
> =C2=A0=C2=A0=C2=A0 https://dpdk.org/browse/dpdk-stable/
>=20
> Thanks.
>=20
> Kevin
>=20
> ---
> Aarnav JP (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/packet_ordering: fix format speci=
fier for port ID
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/ptpclient: fix format specifier f=
or port ID
>=20
> Ajit Khaparde (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bnxt: support statistics query when po=
rt is stopped
>=20
> Anatoly Burakov (13):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ixgbe: add missing E610 MAC type check=
s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ixgbe: fix memory leak in security flo=
ws
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ixgbe: fix potential null dereference =
with IPsec config
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ixgbe: fix potential null dereference =
in IPsec flow
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ixgbe: fix pointer handling in IPsec
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/i40e: move filter config to flow creat=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/i40e: fix IPv6 GTPU handling
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/iavf: fix memory leak on egress IPsec =
flows
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/iavf: fix memory leak on uninit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/iavf: fix IPv4 flow subscription
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice: fix memory leak in DCF QoS bandwi=
dth config
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice: fix memory leak in FDIR flow pars=
ing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/iavf: fix struct size in IPsec status =
get
>=20
> Andrew Bailey (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dts: show missing NIC capabilities in logs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dts: fix doc for RSS test suite
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dts: fix doc for QinQ test suite
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dts: reduce digit count in single core for=
warding metrics
>=20
> Anurag Mandal (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/testpmd: fix function names in logs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/i40e: fix QinQ stripping
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/iavf: fix deletion of primary MAC addr=
ess
>=20
> Ashok Kumar Natarajan (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/axgbe: fix 100M SGMII mode
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/axgbe: fix MAC TCR speed select field =
width
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/axgbe: add 100 Mbps MAC speed select
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/axgbe: fix auto-negotiation capabiliti=
es
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/axgbe: fix SGMII auto-negotiation stat=
us bits
>=20
> Bing Zhao (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix counters resource leak
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix NAT64 HW registers calculati=
on
>=20
> Bruce Richardson (33):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu: fix build with MSVC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice/base: disable MSVC warning
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/red: fix some undefined behaviour
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/timer: fix hang on secondary process =
failure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buildtools/test: suppress empty output
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eal: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbdev: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ethdev: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eventdev: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcapng: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipeline: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 table: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus/pci: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/cpfl: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/e1000: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/i40e: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ixgbe: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/graph: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/pdump: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/testpmd: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config/arm: fix 32-bit build
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hash: fix maybe-uninitialized warnings on =
build
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/intel: fix memory leak on Tx queue set=
up failure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma/idxd: mark portal pointer as volatile
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test: fix dependencies on net null driver
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hash: fix overflow of 32-bit offsets
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/security: skip inline protocol test i=
f no HW support
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bonding: clamp Rx free threshold for s=
mall rings
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usertools/pmdinfo: fix search for PMD info=
 string
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice/base: fix double HW reinitializati=
on
>=20
> Chengwen Feng (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/hns3: fix outer UDP checksum with simp=
le BD
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/testpmd: check start for DCB forwardin=
g TC commands
>=20
> Ciara Loftus (15):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: fix TSO and checksum offload feature =
status for ice
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: fix TSO feature status for iavf
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: fix inline crypto feature status for =
iavf
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: fix TSO feature status for i40e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/intel: prevent selection of a null Rx =
burst function
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice: check null scheduler root node
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice: fix priority mode printing in Tx =
scheduler dump
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice: re-enable strict priority on non-=
root levels
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/i40e: fix secondary process Rx path se=
lection
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/iavf: fix secondary process Rx path se=
lection
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice: fix secondary process Rx path sel=
ection
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/iavf: fix order of tags for AVX512 Tx =
QinQ offload
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/i40e: validate raw flow items before d=
ereferencing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: remove references to obsolete testpmd=
 flag
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/i40e: fix raw flow item validation
>=20
> Congjie Zhou (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eal/linux: fix fbarray name collision in c=
ontainers
>=20
> Dariusz Sosnowski (13):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/testpmd: fix flow queue job leaks
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix default memzone requirements=
 in HWS
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix flow mark reading after reco=
nfigure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix shared Rx queue limitations
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/mlx5: fix bonding check
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix bonding check
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix probing to allow BlueField S=
ocket Direct
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix default flow engine on Windo=
ws
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix VXLAN and NVGRE encap in asy=
nc flow API
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix VLAN strip info for CQE comp=
ression
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix flex item capability check
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/mlx5: fix error logging for queue m=
odify
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: report share group and queue ID
>=20
> David Marchand (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/tap: remove log when running without m=
ultiprocess
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/af_xdp: fix external mbuf transmit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eal/linux: fix HPET symbols export
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/mlx5: fix MAC deletion on Linux
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/vm_power_manager: fix format spec=
ifier for port ID
>=20
> Dean Marx (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dts: fix docstring typo in dynamic queue s=
uite
>=20
> Dimon Zhao (10):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: fix integer overflow
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: fix null pointer dereference
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: check ioctl returns
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: fix memzone leak on queue release
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: fix mbuf headroom usage in packet=
 Tx
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: fix mbuf double-free in queue cle=
anup
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: improve mailbox exception handlin=
g
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: fix hardware stats interrupt nest=
ing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: checks for unsupported UIO driver=
s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nbl: fix queue stats on restart
>=20
> Emma Finn (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/fips_validation: fix dangling poi=
nters
>=20
> Garvit Varshney (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crypto/cnxk: return decrypted data for RSA=
 verify
>=20
> Gregory Etelson (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net: fix packet type for stacked VLAN
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix MPESW PF probe for any numbe=
r of ports
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix flow metadata between E-Swit=
ch and VM
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix flow metadata sharing with E=
-Switch and VM
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix IPv6 SRH flex node header le=
ngth
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix IPv6 SRH flex parser initial=
ization
>=20
> Grzegorz Nitka (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice/base: fix adjust timer programming=
 for E830
>=20
> Hailin Xu (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: fix E830 recommended firmware in ice =
guide
>=20
> Howard Wang (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/r8169: fix crash in RTL8168FP init
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/r8169: fix RTL8168KB speed classificat=
ion
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/r8169: ensure old mapping is used
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/r8169: fix bitmask logic for RTL8127
>=20
> Itai Sharoni (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5/windows: fix MAC address ownershi=
p tracking
>=20
> Ivan Malov (7):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/sfc_efx/base: fix flow control on l=
egacy MCDI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/sfc_efx/base: fix indication of req=
uestable FEC flags
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/sfc_efx/base: define mask for pause=
 mode capabilities
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/sfc: avoid speed reset when setting FE=
C in started state
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/sfc: rework capability check that is d=
one on FEC set
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/sfc: drop AUTO from FEC capabilities a=
nd fix comment
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/sfc: fix reporting status of autonegot=
iation
>=20
> Jacob Keller (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/iavf: negotiate PTP before reporting R=
x timestamping
>=20
> John McNamara (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/i40e: fix unused variable
>=20
> Junfeng Guo (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix IP tunnel detection with HWS
>=20
> Kai Ji (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crypto/openssl: fix SM2 public key buffer =
overflow
>=20
> Keegan Freyhof (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bnxt: fix commas instead of semicolons
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bnxt: fix reported VLAN stripped flag =
for Thor2
>=20
> Kevin Traynor (8):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/vm_power: fix format-truncation w=
arning
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eal/linux: handle interrupt epoll events
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts: add interrupt event info
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: check DevX disconnect/error inte=
rrupt events
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vhost: fix resource leak on driver registr=
ation failure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bnxt: fix uninitialized read
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/testpmd: fix FD leak in mbuf history c=
ommand parsing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/ipsec-secgw: fix build with glibc=
 2.43
>=20
> Kishore Padmanabha (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bnxt: fix statistics for high number o=
f queues
>=20
> Liangxing Wang (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/dma-perf: fix reversed CPU copy
>=20
> Long Li (14):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/netvsc: fix race conditions on VF add/=
remove events
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/netvsc: support multi-process VF devic=
e removal
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mana: fix PD resource leak on device c=
lose
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/netvsc: fix devargs memory leak on hot=
plug
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mana: fix fast-path ops setup in secon=
dary process
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix fast-path ops setup in secon=
dary process
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx4: fix fast-path ops setup in secon=
dary process
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/netvsc: fix subchannel leak on device =
removal
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/netvsc: fix double-free of primary Rx =
queue on uninit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/netvsc: fix resource leak on init fail=
ure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/netvsc: fix event callback leak on Rx =
filter failure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/netvsc: fix resource leaks on MTU chan=
ge
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mana: fix CQE suppression handling on =
error completions
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/netvsc: switch data path to synthetic =
on device stop
>=20
> Lukas Sismis (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dts: fix doc generation for testpmd shell
>=20
> Maayan Kashani (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix flow devargs handling for fu=
ture HW
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix internal HWS pattern templat=
e creation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix redundant control rules in p=
romiscuous mode
>=20
> Maciej Paczkowski (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice/base: fix integer types in compari=
sons
>=20
> Manish Kurup (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bnxt: fix crash in HWRM capabilities q=
uery
>=20
> Marat Khalili (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf: fix x86 call stack alignment for exte=
rnal calls
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitops: allow variable as first argument o=
f shift macros
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf: fix signed shift overflows in ARM JIT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf: disallow empty program
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf: fix add/subtract overflow
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf: fix starting with conditional jump
>=20
> Martin Spinler (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nfb: use constant values for max Rx/Tx=
 queues count
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nfb: fix bad pointer access in queue s=
tats
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nfb: use process private variable for =
internal
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nfb: fix resources release
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/nfb: stop only started queues in fail =
path
>=20
> Maxime Coquelin (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vhost: fix virtqueue array size for contro=
l queue
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vhost: fix descriptor chain bounds check i=
n control queue
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vhost: fix mmap error check in VDUSE IOTLB=
 miss handler
>=20
> Maxime Leroy (14):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix queue block memory leak on =
port close
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix Rx error queue memory leaks
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: warn on Rx descriptor limit in =
high perf mode
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix resource leak on soft parse=
r failure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix link after port stop/start
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus/fslmc: fix devargs not propagated on h=
otplug
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix spurious VLAN insertion on =
non-VLAN packet
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix error packet dump
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix L4 packet type in slow pars=
e path
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix L3/L4 checksum offload flag=
s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix software taildrop buffer ac=
cess
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix burst mode info
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: add SG table walk upper bound i=
n Rx
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/dpaa2: fix MAC stats DMA alloc per xst=
ats call
>=20
> Morten Br=C3=B8rup (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ethdev: fix mbuf fast release requirements=
 description
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eal: fix cache guard for pedantic compilat=
ion
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbuf: fix packet data read
>=20
> Nawal Kishor (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/cnxk: fix width of DPC set field
>=20
> Nithinsen Kaithakadan (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/crypto: fix mbuf segment number
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/crypto: fix RSA sign data length
>=20
> Patrick Robb (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dts: sniff only inbound packets
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dts: fix test suite filtering
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dts: avoid resources conflict on quick sto=
p/start
>=20
> Piotr Krzewinski (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cryptodev: fix memory corruption in second=
ary process
>=20
> Radu Nicolau (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdcp: add digest physical address
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crypto/qat: align vector address
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hash: fix unaligned access for CRC
>=20
> Rahul Bhansali (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/cnxk: fix security flag for custom inb=
ound SA
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/cnxk: fix duplicated branches
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/cnxk: fix CPT CQ roll over handling
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event/cnxk: fix crash on CN10K
>=20
> Rakesh Kudurumalla (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/cnxk: fix engine capabilities fetch=
 logic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/l2fwd-jobstats: fix stats availab=
ility
>=20
> Riley Fletcher (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: add IBM Power 10 testing to 25.11 rel=
ease notes
>=20
> Robin Jarry (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/iavf: fix reported max Tx and Rx queue=
s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 telemetry: fix adding dict in container ar=
ray
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hash: avoid leaking entries on RCU defer q=
ueue failure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hash: free replaced data on overwrite when=
 RCU is configured
>=20
> Rongwei Liu (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix job leak on indirect meter c=
reation failure
>=20
> Sameer Vaze (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compress/zlib: fix UDC checksum
>=20
> Scott Mitchell (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eal: fix annotation on lcore variable allo=
cator
>=20
> Sergei Iashin (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eventdev/eth_rx: fix crash with telemetry
>=20
> Shaiq Wani (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/idpf: fix typo in CQ scan threshold ma=
cro name
>=20
> Shani Peretz (10):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/ethtool: fix size of mempool name
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/testpmd: fix memory leak in port attac=
h
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5/hws: fix stack alignment for ASan=
 compatibility
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5/hws: fix null dereference in rule=
 skip
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: allow MTU mismatch for running s=
hared queue
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vhost: fix use-after-free race during clea=
nup
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/testpmd: fix memory leak in port flow =
configure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config/arm: drop crypto extension from Cor=
tex-A78AE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix meter ASO action leak on rel=
ease to pool
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix heap buffer overflow in samp=
le group match
>=20
> Song Yoong Siang (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/e1000: use device timestamp for clock =
read in igc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/e1000: fix allocation of context desc =
for launch time
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/e1000: fix igc launch time calculation
>=20
> Sriram Yagnaraman (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/memif: fix descriptor Tx flags corrupt=
ion
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/memif: fix multi-segment Rx corruption
>=20
> Stephen Hemminger (40):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/cnxk: fix array out-of-bounds
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/fips_validation: fix RSA memcpy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bnxt: fix build with GCC 16
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/table: avoid input line overflow
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/cfgfile: avoid temp filename truncati=
on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/crypto: check for vdev args overflow
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcapng: document return values
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcapng: use malloc instead of fixed buffer=
 size
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcapng: chain additional mbuf when comment=
 exceeds tailroom
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/pcapng: skip test if null driver miss=
ing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/cnxk: remove VLA in interrupt confi=
guration
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/cnxk: fix buffer overflow in SA set=
up
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix build with LTO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bnxt: remove unbuilt source files
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix null dereference in Tx queue=
 start
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix counter leak in hairpin queu=
e setup
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix use-after-free in ASO manage=
ment init
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix counter truncation in queue =
counter read
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/tap: fix handling of queue stats
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/tap: use correct length for interface =
names
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/tap: fix resource leaks on creation fa=
ilure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/tap: fix resource leaks in secondary p=
rocess probe
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/tap: free IPC reply buffer on queue co=
unt mismatch
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/tap: fix use-after-free on remote flow=
 creation failure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/tap: free remote flow when implicit ru=
le already exists
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/pcapng: fix for Windows
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test: add pause to synchronization spinloo=
ps
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/atomic: scale test based on core coun=
t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/mcslock: scale test based on core cou=
nt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/stack: scale test based on core count
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/timer: scale test based on core count
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/timer: replace volatile with C11 atom=
ics
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test: add file-prefix for all fast-tests o=
n Linux
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/trace: fix parallel execution with tr=
aces enabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/bpf: fix error handling in ELF load t=
ests
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/bpf: fix unsupported instructions in =
ELF load test
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/bpf: fix payload size for Rx/Tx load =
tests
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/vmdq_dcb: initialize all configur=
ation structures
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/memcpy: reduce alignment offset cover=
age
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test/latency: relax check on zero latency
>=20
> Sunyang Wu (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: add --query-rate option in flow-perf =
guide
>=20
> Talluri Chaitanyababu (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/testpmd: fix DCB forwarding TC mismatc=
h handling
>=20
> Tejasree Kondoj (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/cnxk: fix cipher key length validat=
ion
>=20
> Thierry Herbelot (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/intel: update key length when getting =
RSS key
>=20
> Thomas Monjalon (7):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/mlx5: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mvpp2: fix variable shadowing
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eal/x86: fix TSC frequency query
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/bnxt/tf_ulp: fix minsize build
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci: fix debug build type
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples/ethtool: fix error message about =
ports limit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem: check fbarray name truncation in seco=
ndary process
>=20
> Venkatesh Vemula (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/intel: fix comma operator warnings
>=20
> Viacheslav Ovsiienko (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix flex parser creation length =
attribute
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix send skew settings when usin=
g wait on time
>=20
> Vipin Varghese (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app/dma-perf: fix buffer overflow with hig=
h core count
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: update AMD EPYC guide
>=20
> Vladimir Medvedkin (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fib: fix prefix addition handling
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/ice: fix RSS LUT access when using glo=
bal LUT
>=20
> Xavier Guillaume (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/af_packet: fix MTU set data size calcu=
lation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/af_packet: fix receive buffer overflow
>=20
> Xiaoyu Min (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix HW flow counter query
>=20
> Yang Xu (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix port down in link detection =
failure
>=20
> Yehor Malikov (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vhost: fix use-after-free fdset during shu=
tdown
>=20
> Yunjian Wang (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/mlx5: fix memory leak after device spa=
wn failure
>=20
> Zhanibek Bakin (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/null: fix Tx statistics accumulation
